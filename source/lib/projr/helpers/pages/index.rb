module Helpers::Pages::Index

  def self.index_slideshow_thumbnail
    Helpers::Thumbnails.elem_to_thumbnail(Helpers::Slideshow::SimpleSlideshow.new(
                                              :id => 'index-slideshow',
                                              :elems => $config[:index][:slideshow][:elems],
                                              :theme => $config[:index][:slideshow][:theme]), 4, false)
  end

  def self.index_video_thumbnail
    Helpers::Thumbnails.elem_to_thumbnail(Helpers::Video::SimpleVideoPlayer.new(
                                              :id => 'index-video',
                                              :file => $config[:index][:video][:file],
                                              :type => $config[:index][:video][:type],
                                              :skin => $config[:index][:video][:skin]), 4, false)
  end

end
