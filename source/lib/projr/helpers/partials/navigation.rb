module Helpers::Partials::Navigation

  def self.navigation_dropdown(elems)
    elems.each { |elem|
      unless elem.has_key?(:weight);
        elem[:weight] = 0
      end }
    elems.sort! { |e1, e2| e1[:weight] <=> e2[:weight] }
    elems.reverse!

    html_elems = []

    dropdowns_elems = { }
    elems.each do |elem|
      if elem.has_key?(:category)
        unless dropdowns_elems.has_key?(elem[:category])
          dropdowns_elems[elem[:category]] = []
        end
        dropdowns_elems[elem[:category]] << {
            :link => elem[:link], :title => elem[:title]
        }
      else
        html_elems << NavElemStandalone.new(
            :link => elem[:link], :title => elem[:title]).to_html
      end
    end

    dropdowns_elems.each do |dropdown_name, dropdown_elems|
      html_elems << NavDropdown.new(
          :name => dropdown_name, :dropdown_elems => dropdown_elems).to_html
    end

    html_elems.join("\n")
  end

  class NavDropdown < Erector::Widget
    def content
      dd_tggl_id = "#{@name.downcase}-label"

      li(:class => 'dropdown') {
        a(:id => dd_tggl_id, :class => 'dropdown-toggle', :role => 'button',
          :'data-toggle' => 'dropdown', :'data-target' => '#', :href => '#') {
          text @name.capitalize
          b(:class => 'caret')
        }
        ul(:class => 'dropdown-menu', :role => 'menu',
           :'aria-labelledby' => dd_tggl_id) {
          @dropdown_elems.each do |dropdown_elem|
            li {
              a(:href => dropdown_elem[:link]) { text dropdown_elem[:title] }
            }
          end
        }
      }
    end
  end

  class NavElemStandalone < Erector::Widget
    def content
      li { a(:href => @link) { text @title } }
    end
  end

end
