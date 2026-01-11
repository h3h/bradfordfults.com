# Patch Perron to use UTF-8 paths for output directories instead of
# percent-encoded paths. Rails URL helpers percent-encode non-ASCII chars,
# but we want UTF-8 directory names for the static site output.
Rails.application.config.after_initialize do
  Perron::Site::Builder::Page.prepend(Module.new do
    def initialize(path)
      @output_path = Rails.root.join(Perron.configuration.output)
      # Decode percent-encoded UTF-8 for file output
      @output_path_segment = URI.decode_www_form_component(path)
      # Re-encode for Rails routing (requires ASCII)
      @path = path
    end

    private

    def save_html(html)
      prefixless_path = @output_path_segment.delete_prefix("/")

      file_path = @output_path.join(prefixless_path)
      file_path = file_path.join("index.html") if File.extname(prefixless_path).empty?

      FileUtils.mkdir_p(file_path.dirname)
      File.write(file_path, html)

      print "\e[32m.\e[0m"
    end
  end)
end

Perron.configure do |config|
  config.output = "output"

  config.site_name = "Bradford Fults"
  config.site_description = "Texan sense and charm."

  # The build mode for Perron. Can be :standalone or :integrated
  config.mode = :standalone

  config.default_url_options = {
    host: "bradfordfults.com",
    protocol: "https",
    trailing_slash: true
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
