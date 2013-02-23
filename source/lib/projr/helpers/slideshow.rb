module Helpers::Slideshow

  # Themeable non-obtrusive and simple slideshow with next/prev controls.
  #
  # To create a {SimpleSlideshow} you have 2 ways:
  # * Extend {SimpleSlideshow} and define the following instance variables
  # * Directly use {SimpleSlideshow} and pass the instance variables as an
  #     hash when you create the object
  #
  # The used instance variables are:
  # * id: the slideshow identifier
  # * theme: the slideshow theme (look the available list below)
  # * size_in_twelfths: The size expressed in twelfths
  #     (e.g. specifying 2 the thumbnail will occupy 2/12 of the available space)
  # * elems: It should be an Enumerable. Each element should be an Hash with the
  #     following keys:
  #     * :alt: the alternative text
  #     * :title: the element title
  #     * :src: the image url, usually relative to the project root
  #
  # Available themes:
  # * bar
  # * light
  # * default
  # * dark
  #
  class SimpleSlideshow < Erector::Widget
    def content
      wrp_classes = ['slider-wrapper', "theme-#@theme"]
      wrp_classes.push("span#@size_in_twelfths") unless @size_in_twelfths.nil?

      div(:id => "#@id-wrp", :class => wrp_classes.join(' ')) {
        div(:id => "#@id-ribbon", :class => 'ribbon')
        div(:id => @id, :class => 'nivoSlider') {
          @elems.each do |elem|
            img_alt = elem.has_key?(:alt) ? elem[:alt] : ''
            img_title = elem.has_key?(:title) ? elem[:title] : ''
            img(:src => elem[:src], :alt => img_alt, :title => img_title)
          end
        }
      }
    end
  end

end
