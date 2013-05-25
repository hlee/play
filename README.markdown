## Objective

Display how to use sinatra related 

1. rescue
2. activerecord
3. builder
4. rspec
5. DataMapper
6. debugger & pry
7. heroku & cf deploy
8. console with pry & racksh
9. mongodb

```ruby
require 'data_mapper'
#DataMapper.setup(:default, "sqlite3::memory:")
DataMapper.setup(:default, "mysql://user:password@hostname/database")

class Post
  include DataMapper::Resource
  property :id         , Serial
  property :title      , String
  property :body       , Text
  property :created_at , DateTime
end
```

## Demo


## How to run console

```ruby
  pry -r my_app.rb
```