#ENV['RACK_ENV'] = 'test'
require File.expand_path '../../my_app.rb', __FILE__
require 'rack/test'
OUTER_APP = Rack::Builder.parse_file('config.ru').first
RSpec.configure do |config|
  module Helpers
    include Rack::Test::Methods
    def app
      OUTER_APP
    end
  end
  config.include Helpers
end