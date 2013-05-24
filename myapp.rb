#myapp.rb
require 'sinatra'
require 'rubygems'
require 'builder'
require 'active_record'
require 'slim'
require 'debugger'
#env = ENV["RACK_ENV"]

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  database: 'lazer',
  username: 'root',
  password: 'password'
)
# create database lazer;  use lazer; create table posts ( id mediumint not null auto_increment, name char(50),primary key (id) );


class Article < ActiveRecord::Base
end

class Post < ActiveRecord::Base
end

get '/' do
  Article.establish_connection(
    adapter: 'sqlite3',
    database: 'sin.sqlite'
  )
  @articles = Article.all
  @posts = Post.all
  slim :index
end

set(:probability) { |value| condition { rand <= value } }

get '/win', probability: 0.5 do
  code = "You Won! <%= Time.now %>"
  erb code
end

get '/win' do
  erb :win
end

#get '/home' { haml 'h1 Haml Hello' }
get '/home' do 
  haml 'h1 Haml Hello'
end

#get '/feed', provides: ['rss', 'xml'] do
get '/feed.rss' do
  builder { |xml| xml.em 'hi' }
end