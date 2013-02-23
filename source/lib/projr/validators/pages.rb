################################################################################
#
# Entry point for pages validation
#
# Sections:
#   1- Page-specific validators import
#
# NOTE:
#   * All pages validators should be a module under Validators::Pages
#
################################################################################


module Validators::Pages
end


# <= 1 => Page-specific validators import


# Index page validations
require 'projr/validators/pages/index'
