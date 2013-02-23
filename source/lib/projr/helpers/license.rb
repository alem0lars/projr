module Helpers::License

  def self.license_from_config
    license_name = $config[:license].strip

    if /^gpl\s*v?\s*3(?:\s*\.\s*0)?$/i.match(license_name) ||
        /^gpl$/.match(license_name) # the default gpl is v3.0
      RestClient.get('http://www.gnu.org/licenses/gpl-3.0-standalone.html').body
    elsif /^gpl\s*v?\s*2(?:\s*\.\s*0)?$/i.match(license_name)
      RestClient.get('http://www.gnu.org/licenses/old-licenses/'\
          'gpl-2.0-standalone.html').body
    elsif /^mit/i.match(license_name)
      MitLicense.new(
          :year => Time.now.year, :author_name => $config[:author][:name]).to_html
    end
  end

  class MitLicense < Erector::Widget
    def content
      div {
        p "Copyright (c) #@year #@author_name"
        p 'Permission is hereby granted, free of charge, to any person '\
          'obtaining a copy of this software and associated documentation '\
          'files (the "Software"), to deal in the Software without restriction, '\
          'including without limitation the rights to use, copy, modify, merge, '\
          'publish, distribute, sublicense, and/or sell copies of the Software, '\
          'and to permit persons to whom the Software is furnished to do so, '\
          'subject to the following conditions:'
        ul {
          li 'The above copyright notice and this permission notice shall be '\
              'included in all copies or substantial portions of the Software.'
          li 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, '\
             'EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES '\
             'OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND '\
             'NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT '\
             'HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, '\
             'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING '\
             'FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR '\
             'OTHER DEALINGS IN THE SOFTWARE.'
        }
      }
    end
  end

end
