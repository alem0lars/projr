module Helpers::Services
end


# Require all of the services helpers
require 'projr/helpers/services/github'
require 'projr/helpers/services/masterbranch'
require 'projr/helpers/services/twitter'


module Helpers::Services

  # @return [String] the thumbnails for the services
  #
  def self.services_thumbnails
    thumbs_non_std_count = 4

    thumbs = []

    # ==> Available thumbnails registration

    avail_thumbs = { :std => [], :non_std => [] }

    avail_thumbs[:std].push(Helpers::Services::Github::Thumbnail.new) if Validators::Services::Github.validate_github_config
    avail_thumbs[:non_std].push(Helpers::Services::Github::TravisBadge.new) if Validators::Services::Github.validate_travis_config
    avail_thumbs[:non_std].push(Helpers::Services::Github::GemnasiumBadge.new) if Validators::Services::Github.validate_gemnasium_config
    avail_thumbs[:non_std].push(Helpers::Services::Masterbranch::Badge.new) if Validators::Services::Masterbranch.validate_masterbranch_config
    avail_thumbs[:non_std].push(Helpers::Services::Twitter.follow_badge_from_config) if Validators::Services::Twitter.validate_twitter_follow_config

    # ==> Generate the standalone thumbnails

    avail_thumbs[:std].each { |thumb| thumbs << thumb.to_html }

    # ==> Generate the non-standalone thumbnails

    thumbs_memo = []
    avail_thumbs[:non_std].each_with_index do |thumb_elem, idx|
      thumbs_memo << thumb_elem

      if (idx == (avail_thumbs[:non_std].size - 1)) ||
          (((idx % (thumbs_non_std_count + 1)) == 0) && (idx > 0))
        # flush the thumbs_memo into thumbs
        thumbs_memo.insert(0, NonStandaloneTitle.new(:first => idx == 0))
        thumbs << Helpers::Thumbnails.elem_to_thumbnail(thumbs_memo, 2, true)
        thumbs_memo = []
      end
    end

    thumbs.join("\n")
  end

  # Title used for non-standalone services
  #
  # To create a {NonStandaloneTitle} you have 2 ways:
  # * Extend {NonStandaloneTitle} and define the following instance variables
  # * Directly use {NonStandaloneTitle} and pass the instance variables as an
  #     hash when you create the object
  #
  # The used instance variables are:
  # * first: If true the title says that this is not the first service
  #     (e.g. 'Some other services')
  #
  class NonStandaloneTitle < Erector::Widget
    def content;
      h4 "#{@first ? 'Some other' : 'Other'} services:"
    end
  end

end
