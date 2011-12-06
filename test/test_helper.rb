require 'test/unit'

begin
  require 'ruby-debug'
rescue LoadError
end

require 'bundler'
require 'lib/thumbnail'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
