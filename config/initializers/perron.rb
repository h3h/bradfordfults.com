Perron.configure do |config|
  config.output = "public"

  config.site_name = "Bradford Fults"
  config.site_description = "Texan sense and charm."

  # The build mode for Perron. Can be :standalone or :integrated
  config.mode = :standalone

  # In `integrated` mode, the root is skipped by default. Set to `true` to enable
  # config.include_root = false

  config.default_url_options = {
    host: "bradfordfults.com",
    protocol: "https",
    trailing_slash: false
  }

  config.allowed_extensions = %w[erb md]
  config.view_unpublished = Rails.env.development?

  # Sitemap
  config.sitemap.enabled = true
  config.sitemap.priority = 0.5
  config.sitemap.change_frequency = :monthly

  # The options hash is passed directly to the chosen library
  # config.markdown_options = {}

  # Set default meta values
  # Examples:
  # - `config.metadata.description = "Add forms to any static site. Display responses anywhere."`
  # - `config.metadata.author = "Chirp Form Team"`

  # Set meta title suffix
  # config.metadata.title_suffix = nil
  # config.metadata.title_separator = " — "
end
