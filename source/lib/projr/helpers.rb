################################################################################
#
# Entry point for the helpers
#
# An helper is basically a module that can be used to generate generally some
# markup, although conceptually they could be used to generate scripts, styles,
# etc..
#
# Sections:
#   1- Helpers import
#
# NOTE:
#   * Even if helpers are just ruby code, they should use Erector to generate
#     html code (e.g. using Erector::Widget).
#     This is just a convention to have more readable and consistent code and
#     to empower reusability
#
################################################################################


module Helpers
end


# <= 1 => Helpers import


# Helpers for thumbnails
# For more details look in "./helpers/thumbnails.rb"
require 'projr/helpers/thumbnails'

# Helpers for services
# For more details look in "./helpers/services.rb"
require 'projr/helpers/services'

# Helpers for slideshow
# For more details look in "./helpers/slideshow.rb"
require 'projr/helpers/slideshow'

# Helpers for video
# For more details look in "./helpers/video.rb"
require 'projr/helpers/video'

# Helpers for license
# For more details look in "./helpers/license.rb"
require 'projr/helpers/license'

# Helpers used to handle partials
# For more details look in "./helpers/partials.rb"
require 'projr/helpers/partials'

# Helpers used to handle pages
# For more details look in "./helpers/pages.rb"
require 'projr/helpers/pages'
