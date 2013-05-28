require 'data_mapper'
require 'active_record'

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

class Post < ActiveRecord::Base
end