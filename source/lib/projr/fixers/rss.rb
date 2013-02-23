module Fixers::Rss

  def self.fix_rss_config
    if Validators::Rss.validate_rss_config
      rss_files = $config[:rss][:files]
      $config[:rss][:files] = []
      rss_files.each do |entry|
        Dir.glob(File.join($config[:root_pth], entry)) do |file_pth|
          $config[:rss][:files].push(file_pth)
        end
      end
    end
  end

end
