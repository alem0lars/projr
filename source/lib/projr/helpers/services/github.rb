module Helpers::Services::Github

  # @return [String] github link from the global configuration
  #
  def self.github_link
    user_name = $config[:services][:github][:user_name]
    repo_name = $config[:services][:github][:repo_name]
    "https://github.com/#{user_name}/#{repo_name}"
  end

  # @return [String] gemnasium link from the global configuration
  #
  def self.gemnasium_link
    user_name = $config[:services][:github][:user_name]
    repo_name = $config[:services][:github][:repo_name]
    "https://gemnasium.com/#{user_name}/#{repo_name}"
  end

  # @return [String] travis link from the global configuration
  #
  def self.travis_link
    user_name = $config[:services][:github][:user_name]
    repo_name = $config[:services][:github][:repo_name]
    "https://travis-ci.org/#{user_name}/#{repo_name}"
  end

  # Github standalone thumbnail
  #
  # To create a {Helpers::Services::Github::Thumbnail} you have 2 ways:
  # * Extend {Helpers::Services::Github::Thumbnail} and define the following
  #     instance variables
  # * Directly use {Helpers::Services::Github::Thumbnail} and pass the
  #     instance variables as an hash when you create the object
  #
  class Thumbnail < Helpers::Thumbnails::StandaloneThumbnail
    def initialize(*args)
      super(*args)
      @img_href, @title_href = Helpers::Services::Github.github_link
      @img_src = "/#{$config[:images_name]}/app/github-logo.png"
      @img_width, @img_height, @img_alt = ''
      @title_text = 'Fork me on Github'
      @sized = true
    end
  end

  # Travis badge
  #
  # To create a {Helpers::Services::Github::TravisBadge} you have 2 ways:
  # * Extend {Helpers::Services::Github::TravisBadge} and define the following
  #     instance variables
  # * Directly use {Helpers::Services::Github::TravisBadge} and pass the
  #     instance variables as an hash when you create the object
  #
  class TravisBadge < Erector::Widget
    def initialize(*args)
      super(*args)
      @img_src = "#{Helpers::Services::Github.travis_link}.png?branch=master"
      @img_width = 89
      @img_height = 13
      @img_alt = ''
    end

    def content
      a(:class => 'travis-badge-wrp badge-wrp', :href => Helpers::Services::Github.travis_link) {
        img(:class => 'travis-badge-img badge-img', :src => @img_src,
            :width => @img_width, :height => @img_height, :border => '0',
            :alt => @img_alt)
      }
    end
  end

  # Gemnasium badge
  #
  # To create a {Helpers::Services::Github::GemnasiumBadge} you have 2 ways:
  # * Extend {Helpers::Services::Github::GemnasiumBadge} and define the
  #     following instance variables
  # * Directly use {Helpers::Services::Github::GemnasiumBadge} and pass the
  #     instance variables as an hash when you create the object
  #
  class GemnasiumBadge < Erector::Widget
    def initialize(*args)
      super(*args)
      @img_src = "#{Helpers::Services::Github.gemnasium_link}.png"
      @img_width = 132
      @img_height = 13
      @img_alt = ''
    end

    def content
      a(:class => 'gemnasium-badge-wrp badge-wrp', :href => Helpers::Services::Github.gemnasium_link) {
        img(:class => 'gemnasium-badge-img badge-img', :src => @img_src,
            :width => @img_width, :height => @img_height, :border => '0',
            :alt => @img_alt)
      }
    end
  end

end
