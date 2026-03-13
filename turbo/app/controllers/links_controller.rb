class LinksController < ApplicationController
  include SubscriptionGating

  before_action :require_subscription, only: %i[new create]

  def index
    @links = current_user.links.includes(:tags).order(created_at: :desc)
    @page_title = "Links"
  end

  def show
    @link = current_user.links.find(params.expect(:id))
    @page_title = @link.title
  end

  def new
    @link = current_user.links.build
    @page_title = "Add a link"
  end

  def edit
    @link = current_user.links.find(params.expect(:id))
    @page_title = "Edit link"
  end

  def create
    @link = current_user.links.build(link_params)
    if @link.save
      update_tags(@link)
      redirect_to @link, notice: native_app? ? nil : "Link saved."
    else
      @page_title = "Add a link"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @link = current_user.links.find(params.expect(:id))
    if @link.update(link_params)
      update_tags(@link)
      redirect_to @link, notice: native_app? ? nil : "Link updated."
    else
      @page_title = "Edit link"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.links.find(params.expect(:id)).destroy!
    redirect_to links_path, status: :see_other, notice: native_app? ? nil : "Link removed."
  end

  private

  def link_params
    params.expect(link: [:title, :url, :description])
  end

  def update_tags(link)
    tag_names = params[:link][:tags].to_s.split(",").map(&:strip).reject(&:blank?)
    tags = tag_names.map { |name| Tag.find_or_create_by!(name: name.downcase) }
    link.tags = tags
  end
end
