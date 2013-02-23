module Compilers::TestServer

  def self.compile
    test_server_code = <<-EOSINATRA
require 'sinatra/base'

# The output directory
$root = ::File.dirname(__FILE__)

class SinatraStaticServer < Sinatra::Base

  get(/.+/) do
    send_sinatra_file(request.path) { 404 }
  end

  not_found do
    send_sinatra_file('404.html') { "Sorry, I cannot find \#{request.path}" }
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join($root, path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z0-9]+$/i
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
    EOSINATRA

    config_ru_pth = $config[:out_pth].join('config.ru')

    File.open(config_ru_pth, 'w') { |f| f.write(test_server_code) }
  end

end
