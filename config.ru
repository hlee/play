#config.ru
require File.expand_path '../my_app.rb', __FILE__
#require './my_app' as same of above which is standard
require 'resque/server'

run Rack::URLMap.new({
  '/' => MyApp,
  '/basic'  => AuthProtect::BasicProtected,
  '/digest' => AuthProtect::DigestProtected,
  '/resque' => Resque::Server.new
})