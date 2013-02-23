################################################################################
#
# Sections:
#   1- Fixers import
#
# NOTE:
#   * Fixers are functions that fix existing entities, especially the
#     configuration
#       * For example if you want that in the configuration a user can specify
#         a domain name in different ways and you want to canonize it,
#         you can use a fixer
#       * Another usage case is to provide default values
#
################################################################################


module Fixers
end


# <= 1 => Fixers import


# Fixers for services
# For more details look in "./fixers/services.rb"
require 'projr/fixers/services'

# Fixers for RSS
# For more details look in "./fixers/rss.rb"
require 'projr/fixers/rss'

# Fixers for pages related data
# For more details look in "./fixers/pages.rb"
require 'projr/fixers/pages'
