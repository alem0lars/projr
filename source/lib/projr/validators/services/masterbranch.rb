################################################################################
#
# Validation for the masterbranch service
#
################################################################################


module Validators::Services::Masterbranch

  # Validate the configuration for the service masterbranch
  # A valid masterbranch configuration should be like:
  #   services:
  #     masterbranch:
  #       username: my_masterbranch_username
  #       badge_type: my_badge_type
  # Where my_badge_type can be one of:
  #   cv_short, cv_long, prof_short, prof_long, resume_short or resume_long
  def self.validate_masterbranch_config
    Either.chain do
      bind -> {
        ($config.has_key?(:services) &&
            $config[:services].has_key?(:masterbranch)
        ) ? Success('Valid basic masterbranch config') :
            Failure('Invalid basic masterbranch config')
      }
      bind -> {
        $config[:services][:masterbranch].has_key?(:user_name) ?
            Success('Valid masterbranch username') :
            Failure('Invalid masterbranch username')
      }
      bind -> {
        ($config[:services][:masterbranch].has_key?(:badge_type) &&
            $config[:services][:masterbranch][:badge_type].match(
                /^(?:cv|prof|resume)_(?:short|long)$/)
        ) ? Success('Valid masterbranch badge type') :
            Failure('Invalid masterbranch badge type')
      }
    end
  end

end
