################################################################################
#
# Validation for the twitter service
#
################################################################################


module Validators::Services::Twitter

  # Validate the generic part of the twitter configuration
  # A valid twitter configuration should be like:
  #   services:
  #     twitter:
  #       ...
  def self.validate_twitter_config
    ($config.has_key?(:services) &&
        $config[:services].has_key?(:twitter) &&
        $config[:services][:twitter].is_a?(Hash)
    ) ? Success('Valid twitter generic config') :
        Failure('Invalid twitter generic config')
  end

  # Validate the 'follow' part of the twitter configuration
  # A valid follow part of the twitter configuration should be like:
  #   services:
  #     twitter:
  #       follow: my_follow_name
  def self.validate_twitter_follow_config
    Either.chain do
      bind -> { validate_twitter_config }
      bind -> {
        $config[:services][:twitter].has_key?(:follow) ?
            Success('Valid config for twitter follow') :
            Failure('Invalid config for twitter follow')
      }
    end

  end

  # Validate the 'share' part of the twitter configuration
  # A valid follow part of the twitter configuration should be like:
  #   services:
  #     twitter:
  #       share: my_share_name
  # or
  #   services:
  #     twitter:
  #       share:
  #         ...
  def self.validate_twitter_share_config
    Either.chain do
      bind -> { validate_twitter_config }
      bind -> {
        ($config[:services][:twitter].has_key?(:share) &&
            ($config[:services][:twitter][:share].is_a?(Hash) ||
                $config[:services][:twitter][:share])
        ) ? Success('Valid config for twitter share') :
            Failure('Invalid config for twitter share')
      }
    end
  end

end
