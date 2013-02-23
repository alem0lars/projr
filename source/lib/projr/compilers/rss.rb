require 'atom'


module Compilers::Rss

  def self.compile
    if Validators::Rss.validate_rss_config
      files = ($config[:rss][:files].collect do |file_pth|
        rel_file_pth = Pathname.new(file_pth).relative_path_from($config[:root_pth])
        rel_file_pth_no_ext = rel_file_pth.sub(/#{rel_file_pth.extname}$/, '')
        out_file_pth_no_ext = $config[:out_pth].join(rel_file_pth_no_ext)
        puts "Globbing: #{"#{out_file_pth_no_ext}*"}"
        matched_files = Dir.glob("#{out_file_pth_no_ext}*")
        # assume unique files without extension
        matched_files.empty? ? nil : matched_files[0]
      end).compact!
      host = URI.parse($config[:url]).host

      feed = Atom::Feed.new do |f|
        f.title = $config[:title]
        f.links << Atom::Link.new(:href => $config[:url])
        f.updated = Time.now.to_s
        f.authors << Atom::Person.new(:name => $config[:author][:name])
        f.id = host
        files.each do |file_pth|
          rel_file_pth = Pathname.new(file_pth).relative_path_from($config[:out_pth])
          pretty_file_name = rel_file_pth.sub(/#{rel_file_pth.extname}$/, '').basename.to_s.capitalize

          f.entries << Atom::Entry.new do |e|
            e.title = "#{$config[:project_name]}: #{pretty_file_name}"
            e.links << Atom::Link.new(:href => "#{$config[:url]}/#{rel_file_pth}")
            e.id = "#{host}-#{SecureRandom.uuid}"
            e.updated = File.atime(file_pth)
          end
        end

      end

      File.open($config[:out_pth].join($config[:rss_feed_name]), 'w') { |f| f.write(feed.to_xml) }
      true
    else
      # Config is invalid (maybe the user doesn't want RSS) => RSS not generated
      true
    end
  end

end
