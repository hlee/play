require File.expand_path '../../spec_helper.rb', __FILE__

describe 'Views::Index' do
  it "retrun content" do
    get '/'
    last_response.body.should include "Article"
    last_response.should be_ok
  end
  
  it "should work with authenticate" do
    authorize 'ken', 'password'
    get '/basic'
    last_response.body.should eql 'basic secret'
    last_response.should be_ok
  end
end