################################################################################
#
# Sections
#   1- Compilers import
#
################################################################################


module Compilers
end


# <= 1 => Compilers import


# Import compilers for files (like markup, styles, scripts, etc..)
require 'projr/compilers/files'

# Import the compiler for the RSS
require 'projr/compilers/rss'

# Import the compiler for the test server
require 'projr/compilers/test_server'
