class BackupDatabaseJob < ApplicationJob
  queue_as :default

  def perform
    require "aws-sdk-s3"

    db_path = "/data/production.sqlite3"
    backup_path = "/tmp/beervana_backup.sqlite3"
    key = "backups/#{Date.current.iso8601}.sqlite3"

    # Safe online backup via SQLite .backup command.
    system("sqlite3", db_path, ".backup '#{backup_path}'", exception: true)

    creds = Rails.application.credentials.aws
    client = Aws::S3::Client.new(
      access_key_id: creds[:access_key_id],
      secret_access_key: creds[:secret_access_key],
      region: creds[:region] || "us-west-2"
    )

    File.open(backup_path, "rb") do |file|
      client.put_object(bucket: creds[:bucket], key: key, body: file)
    end

    Rails.logger.info "[Backup] Uploaded #{key} (#{File.size(backup_path)} bytes)"
  ensure
    File.delete(backup_path) if File.exist?(backup_path.to_s)
  end
end
