module Fixers::Pages::Index

  def self.fix_index_video_config
    if Validators::Pages::Index.validate_index_video_config
      uploads_regex = /^\/#{$config[:uploads_name]}.+$/
      unless uploads_regex.match($config[:index][:video][:file])
        $config[:index][:video][:file] =
            "/#{$config[:uploads_name]}/#{$config[:index][:video][:file]}"
      end
    end
  end

  def self.fix_index_slideshow_config
    if Validators::Pages::Index.validate_index_slideshow_config
      uploads_regex = /^\/#{$config[:uploads_name]}.+$/
      $config[:index][:slideshow][:elems].each do |elem|
        unless uploads_regex.match(elem[:src])
          elem[:src] = "/#{$config[:uploads_name]}/#{elem[:src]}"
        end
      end
    end
  end

end
