#config.ru
require File.expand_path '../my_app.rb', __FILE__
#require './my_app' as same of above which is standard
run Rack::URLMap.new({
  '/' => MyApp,
  '/basic' => BasicProtected,
  '/digest' => DigestProtected
})