module Compilers::Files

  def self.compile
    if $config.nil?
      puts 'Compiling aborted'
      return false
    end

    compile_data = [
        { :regex => /^.+(\.(?:erb|rhtml|erubis|haml|liquid|markdown|mkd|md|textile))$/,
          :out_ext => lambda { |_| '.html' },
          :behaviour => lambda { |md, fp|
            # find comment tags
            oc, cc = if /\.haml/.match(md[1]);
                       %w(# )
                     elsif /\.liquid/.match(md[1]);
                       %w({% %})
                     elsif /\.textile/.match(md[1]);
                       %w(==<!-- -->==)
                     else
                       %w(<!-- -->)
                     end

            if /^#{$config[:partials_pth]}\/.+$/.match(fp) || /^#{$config[:layouts_pth]}\/.+$/.match(fp)
              nil # skip the layouts and partials generation
            else
              line = File.open(fp, 'r') { |f| f.readline } rescue ''
              layout_md = /^#{oc}\s*layout\s*:\s*(\S*)\s*#{cc}$/i.match(line.strip)
              if layout_md.nil?
                Tilt.new(fp).render(self, :config => $config)
              else
                layout_pth = File.join($config[:layouts_pth], layout_md[1])
                if File.exist?(layout_pth)
                  out_lines = File.open(fp, 'r') { |f| f.readlines }
                  out_lines.delete_at(0)
                  tmp_file = Tempfile.new(['template', md[1]])
                  tmp_file.write(out_lines.join(''))
                  tmp_file_pth = tmp_file.path
                  tmp_file.close
                  out_cntn = Tilt.new(layout_pth).render(self, :config => $config) {
                    Tilt.new(tmp_file_pth).render(self, :config => $config)
                  }
                  tmp_file.unlink
                  out_cntn # return
                else
                  Tilt.new(fp).render(self, :config => $config)
                end
              end
            end
          }
        },
        { :regex => /^.+(\.(?:html|xhtml|htm|xml))$/,
          :out_ext => lambda { |_| '.html' },
          :behaviour => lambda { |_, fp| File.open(fp, 'r') { |f| f.read } }
        },
        { :regex => /^.+(\.(?:sass|scss))$/,
          :out_ext => lambda { |_| '.css' },
          :behaviour => lambda { |_, fp|
            Dir.chdir($config[:styles_pth]) do
              Sass::Engine.new(File.open(fp, 'r') { |f| f.read }).render
            end
          }
        },
        { :regex => /^.+(\.less)$/,
          :out_ext => lambda { |_| '.css' },
          :behaviour => lambda { |_, fp|
            Dir.chdir($config[:styles_pth]) do
              Less::Parser.new.parse(File.open(fp, 'r') { |f| f.read }).to_css
            end
          }
        },
        { :regex => /^.+(\.css)$/,
          :out_ext => lambda { |_| '.css' },
          :behaviour => lambda { |_, fp| File.open(fp, 'r') { |f| f.read } }
        },
        { :regex => /^.+(\.(?:coffee|coffeescript))$/,
          :out_ext => lambda { |_| '.js' },
          :behaviour => lambda { |_, fp|
            CoffeeScript.compile(File.open(fp, 'r') { |f| f.read })
          }
        },
        { :regex => /^.+(\.(?:js|javascript))$/,
          :out_ext => lambda { |_| '.js' },
          :behaviour => lambda { |_, fp| File.open(fp, 'r') { |f| f.read } }
        },
        { :regex => /^.+(\.(?:png|svg|jpeg|jpg|gif|mp4|eot|ttf|woff))$/,
          :out_ext => lambda { |ext| ext },
          :behaviour => lambda { |_, fp| File.open(fp, 'r') { |f| f.read } }
        }
    ]

    Dir[$config[:root_pth].join('**', '*')].each do |file_pth|
      out_file_pth = file_pth.sub(/^#{$config[:root_pth]}/, $config[:out_pth].to_s)

      found = false
      compile_data.each do |e|
        if (md = e[:regex].match(out_file_pth)) && !found
          found = true
          out_file_pth.sub!(md[1], e[:out_ext].call(md[1]))

          # for files under markup/pages compile them in the output root dir
          pages_regex = /^(#{$config[:out_pth]})\/#{$config[:markup_name]}\/pages\/(.+)$/
          if (md2 = pages_regex.match(out_file_pth))
            out_file_pth = File.join(md2[1], md2[2])
          end

          unless puts "Compiling #{file_pth} into #{out_file_pth}"
            FileUtils.makedirs(File.dirname(out_file_pth))
            out_file_cntn = e[:behaviour].call(md, file_pth)
            unless out_file_cntn.nil?
              File.open(out_file_pth, 'w') { |out_f| out_f.write(out_file_cntn) }
            end
          end
        end
      end
    end
  end
end
