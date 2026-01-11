Perron.configure do |config|
  config.output = "output"

  config.site_name = "Bradford Fults"
  config.site_description = "Texan sense and charm."

  # The build mode for Perron. Can be :standalone or :integrated
  config.mode = :standalone

  config.default_url_options = {
    host: "bradfordfults.com",
    protocol: "https",
    trailing_slash: false
  }

  config.allowed_extensions = %w[erb md]
  config.view_unpublished = Rails.env.development?

  # Markdown options for kramdown
  config.markdown_options = {
    input: "GFM",
    hard_wrap: false
  }

  # Meta configuration
  config.metadata.author = "Bradford Fults"
  config.metadata.title_separator = " — "
end
