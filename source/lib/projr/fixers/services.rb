module Fixers::Services
end


# Require all of the services fixers
Dir.glob(File.join(File.dirname(__FILE__), 'services', '*.rb')) { |m| require m }
