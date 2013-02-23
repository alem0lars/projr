################################################################################
#
# Entry point for license related validation
#
################################################################################


module Validators::License

  # Validate the license configuration
  # A valid license configuration should be like:
  #   license: my_license_name
  def self.validate_license_config
    $config.has_key?(:license) ?
        Success('Valid license') : Failure('Invalid license')
  end

end

