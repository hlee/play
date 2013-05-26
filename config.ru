require './my_app'
run Rack::URLMap.new({
  '/' => MyApp,
  '/basic' => BasicProtected,
  '/digest' => DigestProtected
})