################################################################################
#
# File sections:
#   1- Generic validation
#   2- Validators import
#   2- Validator example
#
# NOTE:
#   * All validators should be under the module Validators
#     (e.g. Validators::MyValidator)
#   * The validators should be monadic:
#       * All validators should return Success or Failure, which are provided by
#         the monadic gem (see the validator example in the bottom of this file)
#       * Complex validators can (and should) have a monadic style as much as
#         possible, i.e. using Either and Validation applicative functors.
#         For more informations on them, take a look at:
#         https://github.com/pzol/monadic/blob/master/README.md
#   * For the lazy men:
#     If you don't want to use the power of monads, no problem: just write a
#     validator which return Success(some_string) for a successful validation,
#     or Failure(some_string) for a validation failure.
#     To use that validator call the function and then call the success? method
#     (e.g. my_validator.success?)
#
################################################################################


# <= 1 => Generic validation


module Validators

  # Validate the presence and correctness of the required configurations
  def self.validate_required_config

    check_sym = ->(sym) {
      $config.has_key?(sym) ?
          Success("Valid #{sym.to_s}") : Failure("Invalid #{sym.to_s}")
    }

    Validation() do
      check { check_sym.(:title) }
      check { check_sym.(:description) }
      check {
        Either.chain do
          bind -> { check_sym.(:url) }
          bind -> { URI.parse($config[:url]) ?
              Success('Url format correct') : Failure('Url format incorrect')
          }
        end
      }
      check {
        Either.chain do
          bind -> { check_sym.(:author) }
          bind -> { $config[:author].has_key?(:name) ?
              Success('Url format correct') : Failure('Url format incorrect')
          }
        end
      }
      check { check_sym.(:project_name) }
      check { check_sym.(:project_desc) }
    end
  end

end


# <= 2 => Validators import


# Validators related to the services (e.g. github, ...)
# For more details look in "./validators/services.rb"
require 'projr/validators/services'

# Validators related to the RSS
# For more details look in "./validators/rss.rb"
require 'projr/validators/rss'

# Validators related to licensing
# For more details look in "./validators/licensing.rb"
require 'projr/validators/license'

# Validators related to the search
# For more details look in "./validators/search.rb"
require 'projr/validators/search'

# Validators for the partials
# For more details look in "./validators/partials.rb"
require 'projr/validators/partials'

# Validators for the pages
# For more details look in "./validators/pages.rb"
require 'projr/validators/pages'


# <= 3 => Validator Example


# module Validators::ExampleValidator
#   def self.validate
#     first_validation = ->() {
#       ...
#     }
#     second_validation = ->(param_0) {
#       ...
#     }
#
#     Either.chain do
#       bind -> { my_other_validator } # it is a requirement for this validation
#       bind -> {
#         Validator() do
#           check { first_validation.() }
#           check { second_validation.("hello world") }
#         end
#       }
#     end
#   end
# end
