#myapp.rb
require 'sinatra'
require 'builder'

get '/' do
  'Hello world!'
end

set(:probability) { |value| condition { rand <= value } }

get '/win', probability: 0.5 do
  code = 'You Won!'
  erb code
end

get '/win' do
  erb :win
end

#get '/feed', provides: ['rss', 'xml'] do
get '/feed.rss' do
  builder { |xml| xml.em 'hi' }
end