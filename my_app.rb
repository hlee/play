#myapp.rb
require 'sinatra/base'
require 'rubygems'
require 'builder'
require 'slim'
require 'pry'
require 'ap'
#require 'bundler/setup'
#env = ENV["RACK_ENV"]
#Bundler.require(:default)
require 'resque'
require './lib/auth_protect'
require './models'


module CreateArticle
  @queue = :art
  def self.perform(name)
    Article.create(name: name)
  end
end

class MyApp < Sinatra::Base
  get '/' do
    #debugger
    #binding.pry
    @articles = Article.all
    @posts = Post.all
    @students = Student.all
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

  get '/article/:title' do
    Resque.enqueue(CreateArticle, params[:title])
    "Add #{params['title']} artile"
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end