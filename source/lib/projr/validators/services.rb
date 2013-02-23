################################################################################
#
# Entry point for services validation
#
# Sections:
#   1- Services global validation
#   2- Service-specific validators import
#
################################################################################


# <= 1 => Services global validation


module Validators::Services

  def self.validate_services_config
    $config.has_key?(:services) && !$config[:services].empty? ?
        Success('Services config valid') : Failure('Services config invalid')
  end

end


# <= 2 => Service-specific validators import


# Github service validators
require 'projr/validators/services/github'

# Masterbranch service validators
require 'projr/validators/services/masterbranch'

# Twitter service validators
require 'projr/validators/services/twitter'
