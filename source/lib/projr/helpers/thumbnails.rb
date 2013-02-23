module Helpers::Thumbnails

  # A standalone thumbnail has an upper image and an optional lower title and
  # a thumbnail content.
  #
  # To create a {StandaloneThumbnail} you have 2 ways:
  # * Extend {StandaloneThumbnail} and define the following instance variables
  # * Directly use {StandaloneThumbnail} and pass the instance variables as an
  #     hash when you create the object
  #
  # The used instance variables are:
  # * img_href: The image link
  # * img_src: The image src
  # * img_width: The image width
  # * img_height: The image height
  # * img_alt: The alternative text when the image is not available
  # * title_text: (optional) The thumbnail title (class: 'thumbnail-title')
  # * title_href: (optional) The title link. If title_href is absent but the title
  #     is present, the title will be a normal title, otherwise it will contain a
  #     link
  # * content: (optional) If it's a {Proc} then title_text and title_href
  #     will be ignored, otherwise it will be put inside a paragraph
  #     below the thumbnail title (class: 'thumbnail-content')
  # * size_in_twelfths: (optional) The size expressed in twelfths
  #     (e.g. specifying 2 the thumbnail will occupy 2/12 of the available space)
  #
  # The resulting thumbnail (class: 'thumbnail') is wrapped into a list-item
  # because the main reason to use thumbnails is to have many tiled items
  # in the page, so you will need to group those thumbnails in an unordered-list.
  #
  class StandaloneThumbnail < Erector::Widget
    def initialize(*args)
      super(*args)
      @title_href, @title_text, @content = nil
      @sized = false
      @size_in_twelfths = 2
    end

    def content
      thumbnail_classes = %w(thumbnail)
      thumbnail_classes.push('sized') if @sized

      li(:class => "span#@size_in_twelfths") {
        div(:class => thumbnail_classes.join(' ')) {
          a(:href => @img_href) {
            img(:src => @img_src, :width => @img_width, :height => @img_height,
                :alt => @img_alt)
            if !@content.nil? && @content.respond_to?(:call)
              @content.call()
            else
              unless @title_text.nil?
                if @title_href.nil?
                  h4(:class => 'thumbnail-title') { @title_text }
                else
                  a(:href => @title_href, :class => 'thumbnail-title') {
                    h4 @title_text
                  }
                end
                unless @content.nil? # content isn't allowed without title
                  p(:class => 'thumbnail-content') {
                    text @content
                  }
                end
              end
            end
          }
        }
      }
    end
  end

  # Convert one or main generic elements into a thumbnail.
  # This method is frequently used when you have one or more non-thumbnail
  # elements and you want that they become a thumbnail.
  #
  # @param [Array<Erector::Widget>] elems the elements that should be
  #     encapsulated into the thumbnail
  # @param [Integer] size_in_twelfths The size expressed in twelfths
  #     (e.g. specifying 2 the thumbnail will occupy 2/12 of the available space)
  # @param [Boolean] sized (defaults to: false) If true the height of the
  #     thumbnail will be aligned with the height of the higher thumbnail
  #     that is sized
  #
  def self.elem_to_thumbnail(elems, size_in_twelfths, sized = false)
    erector do
      thumbnail_classes = %w(thumbnail)
      thumbnail_classes.push('sized') if sized

      li(:class => "span#{size_in_twelfths}") {
        div(:class => thumbnail_classes.join(' ')) {
          if !elems.is_a?(Array) && elems.is_a?(Erector::Widget)
            elems = Array[elems]
          end
          if elems.is_a?(Array)
            elems.each { |elem| widget(elem) if elem.is_a?(Erector::Widget) }
          end
        }
      }
    end
  end

end
