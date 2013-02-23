################################################################################
#
# This is the entry-point for the Projr library
#
# The Projr is composed by these subsystems:
#   * Config
#   * Validators
#   * Fixers
#   * Helpers
#   * Compilers
#
# Sections:
#   1- Miscellaneous dependencies imports
#   2- Markup/Scripts/Styles-related dependencies imports
#   3- Projr subsystems imports
#   4- Load the configuration and make it globally available
#
# NOTE:
#   * We use the policy that if we want that a dependency should be globally
#     available for all subsystems we import it here
#
################################################################################


# <= 1 => Miscellaneous dependencies imports


require 'fileutils'
require 'pathname'
require 'ostruct'
require 'securerandom'
require 'uri'

# Monads are provided in the whole project.
# They should be used when possible, instead of the standard constructs
require 'monadic'

# Used in the entire projr library to print messages
require 'awesome_print'

# Used to perform http requests
require 'rest_client'


# <= 2 => Markup/Scripts/Styles-related dependencies imports


# Enable Erubis support (http://www.kuwata-lab.com/erubis)
require 'erubis'

# Enable Haml support (http://haml.info)
require 'haml'

# Enable Liquid support (http://liquidmarkup.org)
require 'liquid'

# Enable RedCloth support (=> Textile) (http://redcloth.org)
require 'redcloth'

# Enable RDoc support (https://github.com/rdoc/rdoc)
require 'rdoc'
require 'rdoc/markup'
require 'rdoc/markup/to_html'

# Enable RDiscount support (=> Markdown) (https://github.com/rtomayko/rdiscount)
require 'rdiscount'

# Enable SASS support (http://sass-lang.com)
require 'sass'

# Enable Less support (http://lesscss.org)
require 'less'

# Enable CoffeeScript support (coffeescript.org)
require 'coffee_script'

# Tilt is used to deal with the dependencies listed above using a common and
# generic interface
require 'tilt'

# Enable erector support
# It is mainly used in the helpers (see suggestions on how to write elegant and
# consistent markup in "./projr/helpers.rb")
require 'erector'
include Erector::Mixin
Erector::Widget.prettyprint_default = true


# <= 3 => Projr subsystems import


# Subsystem that handles configuration files
# For more details look in "./projr/config.rb"
require 'projr/config'

# Subsystem that provides validations
# For more details look in "./projr/validators.rb"
require 'projr/validators'

# Subsystem that provides functions to fix existing configurations
# For more details look in "./projr/fixers.rb"
require 'projr/fixers'

# Subsystem that provides helpers, mainly used for the markup.
# For more details look in "./projr/helpers.rb"
require 'projr/helpers'

# Subsystem that provides a way to compile sources into deployable artifacts.
# For more details look in "./projr/compilers.rb"
require 'projr/compilers'


# <= 4 => Load the configuration and make it globally available


# In the block we invoke the global fixers and validators in order to make
# the configuration loading fail if the fixers or validators would fail
Config.load do

  # <= 4.1 => Apply global fixers

  Fixers::Rss.fix_rss_config
  Fixers::Services::Twitter.fix_twitter_config
  Fixers::Pages::Index.fix_index_video_config
  Fixers::Pages::Index.fix_index_slideshow_config

  # <= 4.2 => Apply global validators
  # Validators are being applied after the fixers in order to be sure that
  # the fixers will preserve the correctness of the configuration

  status = Validators.validate_required_config

  raise("Invalid configuration file: #{status.fetch}") unless status.success?

end

