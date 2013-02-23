################################################################################
#
# Entry point for search related validation
#
################################################################################


module Validators::Search

  # Validate the search configuration
  # A valid search configuration should be like:
  #   search:
  #     token: my_search_token
  def self.validate_search_config
    Either.chain do
      bind -> { Validators::Rss.validate_rss_config }
      bind -> {
        ($config.has_key?(:search) &&
            $config[:search].is_a?(Hash) &&
            $config[:search].has_key?(:token) &&
            $config[:search][:token].is_a?(String) &&
            ($config[:search][:token].length > 0)
        ) ? Success('Valid search config') :
            Failure('Invalid search config')
      }
    end
  end

end
