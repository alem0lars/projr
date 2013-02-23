module Fixers::Services::Twitter

  def self.fix_twitter_config
    if Validators::Services::Twitter.validate_twitter_share_config
      unless $config[:services][:twitter][:share].is_a?(Hash)
        $config[:services][:twitter][:share] = { }
      end
      unless $config[:services][:twitter][:share].has_key?(:text)
        $config[:services][:twitter][:share][:text] =
            "#{$config[:project_name]}: #{$config[:project_desc]}"
      end
    end
  end

end
