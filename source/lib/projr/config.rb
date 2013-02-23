module Config

  # { Some conventions

  TEST_SERVER_PORT = 4096

  RSS_FEED_NAME = 'rss.xml'
  MARKUP_NAME = 'markup'
  PARTIALS_NAME = 'partials'
  LAYOUTS_NAME = 'layouts'
  SCRIPTS_NAME = 'scripts'
  STYLES_NAME = 'styles'
  IMAGES_NAME = 'images'
  UPLOADS_NAME = 'uploads'
  CONFIG_NAME = 'config.yml'

  ROOT_PTH = Pathname.new File.dirname(File.dirname(File.dirname(__FILE__)))
  OUT_PTH = ROOT_PTH.dirname
  RSS_FEED_PTH = OUT_PTH.join(RSS_FEED_NAME)
  MARKUP_PTH = ROOT_PTH.join(MARKUP_NAME)
  PARTIALS_PTH = MARKUP_PTH.join(PARTIALS_NAME)
  LAYOUTS_PTH = MARKUP_PTH.join(LAYOUTS_NAME)
  SCRIPTS_PTH = ROOT_PTH.join(SCRIPTS_NAME)
  STYLES_PTH = ROOT_PTH.join(STYLES_NAME)
  IMAGES_PTH = ROOT_PTH.join(IMAGES_NAME)
  UPLOADS_PTH = ROOT_PTH.join(UPLOADS_NAME)

  # }

  # Transform Hash keys into symbols
  # @param [Hash] obj the object to be symbolized
  #
  def self.symbolize(obj)
    if obj.is_a? Hash
      obj.inject({ }) { |m, (k, v)| m[k.to_sym] = symbolize(v); m }
    elsif obj.is_a? Array
      obj.inject([]) { |m, v| m << symbolize(v); m }
    else
      obj
    end
  end

  # Load the configuration
  # @return [Hash] containing the configuration (with keys symbolized)
  def self.load
    begin
      $config = YAML::load(File.open(ROOT_PTH.join(CONFIG_NAME), 'r'))

      # In $config we also include the paths and names for important directories
      # and files
      $config.merge!({
                         :markup_name => MARKUP_NAME,
                         :partials_name => PARTIALS_NAME,
                         :layouts_name => LAYOUTS_NAME,
                         :scripts_name => SCRIPTS_NAME,
                         :styles_name => STYLES_NAME,
                         :images_name => IMAGES_NAME,
                         :uploads_name => UPLOADS_NAME,
                         :root_pth => ROOT_PTH,
                         :out_pth => OUT_PTH,
                         :rss_feed_name => RSS_FEED_NAME,
                         :markup_pth => MARKUP_PTH,
                         :partials_pth => PARTIALS_PTH,
                         :layouts_pth => LAYOUTS_PTH,
                         :scripts_pth => SCRIPTS_PTH,
                         :styles_pth => STYLES_PTH,
                         :images_pth => IMAGES_PTH,
                         :uploads_pth => UPLOADS_PTH,
                         :rss_feed_pth => RSS_FEED_PTH,
                         :test_server_port => TEST_SERVER_PORT
                     })

      # The keys of $config will be converted in symbols
      $config = symbolize($config)

      unless $config.has_key?(:title)
        $config[:title] = $config[:project_name]
      end
      unless $config.has_key?(:description)
        $config[:description] = $config[:project_desc]
      end

      # If a block has been provided execute it in the current context.
      # This is commonly used to raise exceptions if configuration is not valid
      if block_given?
        yield
      end

      # Return the configuration
      $config
    rescue Exception => exc
      puts "Error while loading config: #{exc.message}"

      # Return nil, which means that if an exception is raised when generating
      # the configuration then we can't infer any configuration
      nil
    end
  end

end
