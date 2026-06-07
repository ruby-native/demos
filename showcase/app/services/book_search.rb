require "net/http"
require "json"

# Looks up books on Open Library so the add-book flow can prefill the title,
# author, ISBN, page count, and cover. No API key required. Wrapped in a
# single service so the source can be swapped (Google Books, a barcode lookup)
# without touching the views.
class BookSearch
  ENDPOINT = "https://openlibrary.org/search.json".freeze
  FIELDS   = "title,author_name,isbn,number_of_pages_median,cover_i".freeze
  AGENT    = "Shelf (Ruby Native demo)".freeze

  Result = Data.define(:title, :author, :isbn, :pages, :cover_url)

  def self.search(query, limit: 12)
    new(query, limit:).results
  end

  def initialize(query, limit: 12)
    @query = query.to_s.strip
    @limit = limit
  end

  def results
    return [] if @query.blank?

    # Stable sort keeps Open Library's relevance order within each group while
    # floating results that have a cover to the top for a cleaner-looking list.
    Array(fetch["docs"])
      .filter_map { |doc| build_result(doc) }
      .sort_by.with_index { |result, i| [result.cover_url ? 0 : 1, i] }
  rescue => e
    Rails.logger.warn("BookSearch failed: #{e.class} #{e.message}")
    []
  end

  private

  def fetch
    uri = URI(ENDPOINT)
    uri.query = URI.encode_www_form(q: @query, fields: FIELDS, limit: @limit)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 3
    http.read_timeout = 5

    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = AGENT
    request["Accept"] = "application/json"

    response = http.request(request)
    response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body) : {}
  end

  def build_result(doc)
    title = doc["title"]
    return nil if title.blank?

    Result.new(
      title: title,
      author: Array(doc["author_name"]).first.to_s,
      isbn: best_isbn(doc["isbn"]),
      pages: doc["number_of_pages_median"],
      cover_url: cover_url(doc["cover_i"])
    )
  end

  def best_isbn(isbns)
    list = Array(isbns)
    list.find { |i| i.to_s.length == 13 } || list.first
  end

  def cover_url(cover_id)
    return nil if cover_id.blank?
    "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg"
  end
end
