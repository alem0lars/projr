################################################################################
#
# Validation for the data related to the index page
#
################################################################################


module Validators::Pages::Index

  # Validate the configuration for the index page
  # A valid configuration for the index page should be like:
  #   index: ...
  def self.validate_index
    $config.has_key?(:index) ?
        Success('Valid generic index page config') :
        Failure('Invalid generic index page config')
  end

  # A valid configuration for the video part of the index page should be like:
  #   index:
  #     video:
  #       file: file_name
  #       type: file_type
  #       skin: the_choosen_skin
  # Where:
  #   * file_name is relative to the uploads directory
  #   * file_type is one of: video/mp4, video/webm or video/ogg
  #   * skin is the player skin. Valid values are: vjs-default
  def self.validate_index_video_config
    Either.chain do
      bind ->() { validate_index }
      bind ->() {
        ($config[:index].has_key?(:video) &&
            $config[:index][:video].has_key?(:file) &&
            $config[:index][:video].has_key?(:type) &&
            $config[:index][:video].has_key?(:skin)
        ) ? Success('Valid index video config') :
            Failure('Invalid index video config')
      }
    end
  end

  def self.validate_index_slideshow_config
    Either.chain do
      bind ->() { validate_index }
      bind ->() {
        ($config[:index].has_key?(:slideshow) &&
            $config[:index][:slideshow][:theme] &&
            $config[:index][:slideshow][:elems].is_a?(Array) &&
            !$config[:index][:slideshow][:elems].empty? &&
            $config[:index][:slideshow][:elems].all? { |elem|
              elem.is_a?(Hash) && elem.has_key?(:src)
            }
        ) ? Success('Valid index slideshow config') :
            Failure('Invalid index slideshow config')
      }
    end
  end

  #
  def self.validate_index_main_button_config
    Either.chain do
      bind ->() { validate_index }
      bind ->() {
        ($config[:index].has_key?(:main_button) &&
            $config[:index][:main_button].has_key?(:link) &&
            $config[:index][:main_button].has_key?(:name)
        ) ? Success('Valid index main button config') :
            Failure('Invalid index main button config')
      }
    end
  end

end
