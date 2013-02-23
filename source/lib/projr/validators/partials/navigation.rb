################################################################################
#
# Validation for the data related to the navigation partial
#
################################################################################


module Validators::Partials::Navigation

  # Validate the configuration related to the navigation
  # A valid configuration for the navigation should be like:
  #   nav: ...
  def self.validate_navigation_config
    $config.has_key?(:nav) ?
        Success('Valid navigation config') :
        Failure('Invalid navigation config')
  end

end
