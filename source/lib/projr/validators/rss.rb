################################################################################
#
# Entry point for RSS related validation
#
################################################################################


module Validators::Rss

  # Validate the RSS configuration
  # A valid RSS configuration should be like:
  #   rss:
  #     files:
  #       - file_1
  #       ...
  def self.validate_rss_config
    ($config.has_key?(:rss) &&
        $config[:rss].is_a?(Hash) &&
        $config[:rss].has_key?(:files) &&
        $config[:rss][:files].is_a?(Array) &&
        !$config[:rss][:files].empty?
    ) ? Success('Valid RSS config') : Failure('Invalid RSS config')
  end

end
