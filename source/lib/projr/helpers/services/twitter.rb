module Helpers::Services::Twitter

  # Create a new {Helpers::Services::Twitter::ShareBadge} from the global
  # configuration
  #
  # @return [Helpers::Services::Twitter::ShareBadge]
  #
  def self.share_badge_from_config
    share_data = $config[:services][:twitter][:share]
    args = { }
    [:url, :text, :via_user, :recommended_user, :hashtag].each do |key|
      share_data[key] = share_data.has_key?(key) ? share_data[key] : nil
    end
    ShareBadge.new(args)
  end

  # Create a new {Helpers::Services::Twitter::FollowBadge} from the global
  # configuration.
  #
  # @return [FollowBadge]
  #
  def self.follow_badge_from_config
    FollowBadge.new(:user => $config[:services][:twitter][:follow])
  end

  # Badge for sharing with twitter (a.k.a. twitter share button)
  #
  # To create a {Helpers::Services::Twitter::ShareBadge} you have 2 ways:
  # * Extend {Helpers::Services::Twitter::ShareBadge} and define the following
  #     instance variables
  # * Directly use {Helpers::Services::Twitter::ShareBadge} and pass the
  #     instance variables as an hash when you create the object
  #
  # The used instance variables are:
  # * url
  # * text
  # * via_user
  # * recommended_user
  # * hashtag
  #
  class ShareBadge < Erector::Widget
    def initialize(*args)
      super(*args)
      @attrs = {
          :href => 'https://twitter.com/share',
          :class => 'twitter-share-button'
      }
      if @url;
        @attrs[:'data-url'] = @url
      end
      if @text;
        @attrs[:'data-text'] = @text
      end
      if @via_user;
        @attrs[:'data-via'] = @via_user
      end
      if @recommended_user;
        @attrs[:'data-related'] = @recommended_user
      end
      if @hashtag;
        @attrs[:'data-hashtag'] = @hashtag
      end
    end

    def content
      a(@attrs) { 'Tweet' }
    end
  end

  # Badge for following with twitter (a.k.a. twitter follow button)
  #
  # To create a {Helpers::Services::Twitter::FollowBadge} you have 2 ways:
  # * Extend {Helpers::Services::Twitter::FollowBadge} and define the following
  #     instance variables
  # * Directly use {Helpers::Services::Twitter::FollowBadge} and pass the
  #     instance variables as an hash when you create the object
  #
  # The used instance variables are:
  # * user: username to follow
  #
  class FollowBadge < Erector::Widget
    def content
      a(:href => "https://twitter.com/#@user", :class => 'twitter-follow-button',
        :'data-show-count' => 'false') { "Follow @#@user" }
    end
  end

end
