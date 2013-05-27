#myapp.rb
require 'sinatra/base'
require 'rubygems'
require 'builder'
require 'data_mapper'
require 'active_record'
require 'slim'
require 'pry'
require 'ap'
#require 'bundler/setup'
#env = ENV["RACK_ENV"]
#Bundler.require(:default)
require 'resque'

DataMapper.setup(:default, 'mysql://root:password@localhost/lazer')
class Student
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :age, Integer

  has n, :s_l_relations
  has n, :lessons, through: :s_l_relations
end

class Lesson
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :created_at, DateTime

  has n, :s_l_relations
  has n, :students, through: :s_l_relations
end

class SLRelation
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime

  belongs_to :student
  belongs_to :lesson
end

DataMapper.auto_upgrade!

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

Article.establish_connection(
  adapter: 'sqlite3',
  database: 'sin.sqlite'
)

module CreateArticle
  @queue = :art
  def self.perform(name)
    Article.create(name: name)
  end
end

class Post < ActiveRecord::Base
end

class BasicProtected < Sinatra::Base
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'ken' && password == 'password'
  end

  get '/' do
    'basic secret'
  end
end

class DigestProtected < Sinatra::Base
  get '/' do
    'digest secret'
  end

  def self.new(*)
    app = Rack::Auth::Digest::MD5.new(super) do |username|
      {'ken' => 'password'}[username]
    end
    app.realm = 'Digest Protected Area'
    app.opaque = 'secretkey'
    app
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