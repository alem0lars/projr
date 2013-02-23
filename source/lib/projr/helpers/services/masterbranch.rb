module Helpers::Services::Masterbranch

  # @return [String] masterbranch link from the global configuration
  #
  def self.masterbranch_link
    "https://masterbranch.com/#{$config[:services][:masterbranch][:user_name]}"
  end

  # Create a new {Helpers::Services::Masterbranch::Badge} from the global
  # configuration
  #
  # @return [Helpers::Services::Masterbranch::Badge]
  #
  def self.badge_from_config
    args = { :img_alt => "View #{$config[:author][:name]}'s profile on Masterbranch" }
    case $config[:services][:masterbranch][:badge_type]
      when 'cv_short' then
        args.merge!({
                        :img_src => 'http://static.masterbranch.com/buttons/btn_cv_151x27.png',
                        :img_width => 151, :img_height => 27
                    })
      when 'cv_long' then
        args.merge!({
                        :img_src => 'http://static.masterbranch.com/buttons/btn_cv_195x27.png',
                        :img_width => 195, :img_height => 27
                    })
      when 'prof_short' then
        args.merge!({
                        :img_src => 'http://static.masterbranch.com/buttons/btn_profile_151x27.png',
                        :img_width => 151, :img_height => 27
                    })
      when 'prof_long' then
        args.merge!({
                        :img_src => 'http://static.masterbranch.com/buttons/btn_profile_195x27.png',
                        :img_width => 195, :img_height => 27
                    })
      when 'resume_short' then
        args.merge!({
                        :img_src => 'http://static.masterbranch.com/buttons/btn_resume_151x27.png',
                        :img_width => 151, :img_height => 27
                    })
      when 'resume_long' then
        args.merge!({
                        :img_src => 'http://static.masterbranch.com/buttons/btn_resume_195x27.png',
                        :img_width => 195, :img_height => 27
                    })
    end

    Badge.new(args).to_html
  end

  # Masterbranch badge
  #
  # To create a {Helpers::Services::Masterbranch::Badge} you have 2 ways:
  # * Extend {Helpers::Services::Masterbranch::Badge} and define the following
  #     instance variables
  # * Directly use {Helpers::Services::Masterbranch::Badge} and pass the
  #     instance variables as an hash when you create the object
  #
  # The used instance variables are:
  # * img_width: the width of the badge
  # * img_height: the height of the badge
  # * img_alt: the alternative text when the badge image is not available
  #
  class Badge < Erector::Widget
    def content
      a(:class => 'masterbranch-badge-wrp badge-wrp', :href => Helpers::Services::Masterbranch.masterbranch_link) {
        img(:class => 'masterbranch-badge-img badge-img', :src => @img_src,
            :width => @img_width, :height => @img_height, :border => '0',
            :alt => @img_alt)
      }
    end
  end

end
