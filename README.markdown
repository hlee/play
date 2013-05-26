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

## notes

So far, debugger works perfect with sinatra. step debug

## basic and digest authenticate

![digest_authenticate](https://f.cloud.github.com/assets/83296/564705/86b1f108-c597-11e2-8cdd-59ac2bd75084.png)

run rackup

visit http://localhost:9393/basic or http://localhost:9393/digest

need to clear cache if you just signed in

