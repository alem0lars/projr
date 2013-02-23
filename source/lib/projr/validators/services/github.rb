################################################################################
#
# Validation for the github service (and strictly related services)
#
################################################################################


module Validators::Services::Github

  # Validate configuration for github service
  # A valid github configuration should be like:
  #   services:
  #     github:
  #       user_name: my_github_username
  #       repo_name: my_github_reponame
  def self.validate_github_config
    ($config.has_key?(:services) &&
        $config[:services].has_key?(:github) &&
        $config[:services][:github].has_key?(:user_name) &&
        $config[:services][:github].has_key?(:repo_name)
    ) ? Success('Valid github config') : Failure('Invalid github config')
  end

  # Validate configuration for travis service
  # A valid travis configuration should be like:
  #   services:
  #     github:
  #       user_name: my_github_username
  #       repo_name: my_github_reponame
  #       travis: true
  # Setting travis to true will enable the travis service support,
  # otherwise it will be disabled
  def self.validate_travis_config
    Either.chain do
      bind -> { validate_github_config }
      bind -> {
        ($config[:services][:github].has_key?(:travis) &&
            $config[:services][:github][:travis]
        ) ? Success('Valid travis config') : Failure('Invalid travis config')
      }
    end
  end

  # Validate configuration for gemnasium service
  # A valid gemnasium configuration should be like:
  #   services:
  #     github:
  #       user_name: my_github_username
  #       repo_name: my_github_reponame
  #       gemnasium: true
  # Setting gemnasium to true will enable the gemnasium service support,
  # otherwise it will be disabled
  def self.validate_gemnasium_config
    Either.chain do
      bind -> { validate_github_config }
      bind -> {
        ($config[:services][:github].has_key?(:gemnasium) &&
            $config[:services][:github][:gemnasium]
        ) ? Success('Valid gemnasium config') :
            Failure('Invalid gemnasium config')
      }
    end
  end

end
