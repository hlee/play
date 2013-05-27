source 'https://rubygems.org'
gem 'sinatra', :github => "sinatra/sinatra"

# other dependencies
# view related
gem 'haml'                    # for instance, if you use haml
gem 'slim'
gem 'shotgun'
gem 'foreman'
gem 'resque'
gem 'rake'

# database model related
gem 'mysql2'
gem 'sqlite3'
gem 'activerecord', '~> 3.0'  # maybe you also need ActiveRecord 3.x
gem 'data_mapper'
gem 'dm-mysql-adapter'

# develop and debug
group :development, :test do
  gem 'awesome_print'
  gem 'racksh'
  gem 'debugger'
  gem 'pry'
  gem 'pry-debugger'
end

group :test do
  gem 'rspec', '~> 2.7'
  gem 'rack-test', '~> 0.6', require: 'rack/test'
end