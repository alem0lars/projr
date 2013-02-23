module Helpers::Video

  # HTML5 skinned video player with enhanced video controls.
  #
  # To create a {SimpleVideoPlayer} you have 2 ways:
  # * Extend {SimpleVideoPlayer} and define the following instance variables
  # * Directly use {SimpleVideoPlayer} and pass the instance variables as an
  #     hash when you create the object
  #
  # The used instance variables are:
  # * id: the identifier for the video player
  # * skin: the skin to be used (look the available list below)
  # * file: the path for the video file
  #     (usually it should be relative to the project root)
  # * type: the video type (look the available list below)
  # * size_in_twelfths: (optional) The size expressed in twelfths
  #     (e.g. specifying 2 the thumbnail will occupy 2/12 of the available space)
  #
  # Available skins:
  # * vjs-default
  #
  # Available video types:
  # * video/mp4
  # * video/webm
  # * video/ogg
  #
  class SimpleVideoPlayer < Erector::Widget
    def content
      wrp_classes = %w(video-wrp)
      wrp_classes.push("span#@size_in_twelfths") unless @size_in_twelfths.nil?

      div(:id => "#@id-wrp", :class => wrp_classes.join(' ')) {
        element('video', :id => @id, :class => "video video-js #@skin-skin",
                :controls => '', :preload => 'auto', :'data-setup' => '{}') {
          element('source', :src => @file, :type => @type)
        }
      }
    end
  end

end
