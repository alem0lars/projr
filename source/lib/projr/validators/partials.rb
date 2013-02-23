################################################################################
#
# Entry point for partials validation
#
# Sections:
#   1- Partial-specific validators import
#
# NOTE:
#   * All partials validators should be a module under Validators::Partials
#
################################################################################


module Validators::Partials
end


# <= 1 => Partial-specific validators import


# Navigation partial validations
require 'projr/validators/partials/navigation'
