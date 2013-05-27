require File.expand_path '../../my_app.rb', __FILE__
require 'test/unit'
require 'rack/test'

OUTER_APP = Rack::Builder.parse_file('config.ru').first
class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    #MyApp.new #as well as Sinatra::Application will not support the rack test
    OUTER_APP
  end

  def test_default
    get '/'
    assert_include last_response.body, 'Article'
    assert last_response.ok?
  end
  
  def test_basic_authenticate
    authorize 'ken', 'password'
    get '/basic'
    assert_equal last_response.body, 'basic secret'
    assert last_response.ok?
  end
end