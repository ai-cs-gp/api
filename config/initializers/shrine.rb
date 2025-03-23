require "shrine"

OpenSSL::SSL::VERIFY_PEER =
  OpenSSL::SSL::VERIFY_NONE unless Rails.env.development?
# store_options = { public: true }.merge(Rails.env.production? ? { host: App::Constants::DO_SPACES_BUCKET_ENDPOINT } : {})

Shrine.plugin :activerecord
Shrine.plugin :instrumentation, notifications: ActiveSupport::Notifications
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type, analyzer: :marcel
Shrine.plugin :derivatives
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :pretty_location
Shrine.plugin :data_uri
Shrine.plugin :default_url
Shrine.plugin :store_dimensions
Shrine.plugin :remote_url, max_size: 20.megabytes
Shrine.plugin :url_options,
              public_store: {
                public: true,
                host:
                  (
                    if Rails.env.development?
                      "http://localhost:3000"
                    else
                      App::Constants::S3_BUCKET_ENDPOINT
                    end
                  )
              },
              cache: {
                public: true,
                host:
                  (
                    if Rails.env.development?
                      "http://localhost:3000"
                    else
                      App::Constants::S3_BUCKET_ENDPOINT
                    end
                  )
              }

if Rails.env.development?
  require "shrine/storage/file_system"

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
    public_store:
      Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")
  }
  # elsif ENV.fetch('DATABASE_URL', '').include?('nulldb')
  #   require 'shrine/storage/memory'

  #   Shrine.storages = { cache: Shrine::Storage::Memory.new, store: Shrine::Storage::Memory.new }
else
  require "shrine/storage/s3"

  s3_options = {
    access_key_id: Rails.application.credentials.dig(:s3, :access_key_id),
    secret_access_key:
      Rails.application.credentials.dig(:s3, :secret_access_key),
    bucket: Rails.application.credentials.dig(:s3, :bucket_name) || "gp-admin",
    endpoint: App::Constants::S3_ENDPOINT,
    force_path_style: false,
    region: "us-east-1"
  }

  Shrine.storages = {
    cache:
      Shrine::Storage::S3.new(
        prefix: "cache",
        upload_options: {
          acl: "public-read"
        },
        **s3_options
      ),
    store: Shrine::Storage::S3.new(prefix: "uploads", **s3_options), # private bucket
    public_store:
      Shrine::Storage::S3.new(
        prefix: "public_uploads",
        upload_options: {
          acl: "public-read"
        },
        multipart_threshold: {
          upload: 30.megabytes,
          copy: 200.megabytes
        },
        **s3_options
      ) # same private bucket but with public access policy for files in this prefix
    # public_store: Shrine::Storage::S3.new(prefix: 'public_uploads', public: true, upload_options: { cache_control: 'public, max-age=15552000' }, **s3_options)
  }
end

Shrine.logger = Rails.logger
