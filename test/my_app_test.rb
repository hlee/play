require File.expand_path '../../my_app.rb', __FILE__
require 'test/unit'
require 'rack/test'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    MyApp.new
  end

  def test_default
    get '/'
    assert_include last_response.body, 'Article'
    assert last_response.ok?
  end
end