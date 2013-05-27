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
  rachsh
  pry -r my_app.rb
```

## notes

So far, debugger works perfect with sinatra. step debug

## basic and digest authenticate

```ruby
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

```

run rackup

visit http://localhost:9393/basic or http://localhost:9393/digest

need to clear cache if you just signed in

## Foreman & Resque

resuqe just need perform(define and enqueue trigger) and rake file(for heroku and start)

foreman just need Procfile to organize
<br/>
notes:

if you have zombie workers, the foreman and resque will not work. You's better launch your consoleand terminate those zombies, as below:

```ruby
Resque.workers.each { |w| w.unregister_worker}
#or
Resque.workers.each { |w| w.prune_dead_workers}
#or
Resque.workers.each { |w| w.done_working}
Resque.redis.save
#or
queue_name = 'process_numbers'
Resque.redis.del "queue:#{queue_name}"
```
