module Helpers::Partials

  def self.render(pth)
    begin
      Tilt.new(pth.to_s).render(self, :config => $config)
    rescue Exception => exc
      raise "Error while getting content from template #{pth}\n"\
        "\tReason: #{exc.message}\n\t#{exc.backtrace.join("\n\t")}"
    end
  end

end

# Require all partials helpers
require 'projr/helpers/partials/navigation'
