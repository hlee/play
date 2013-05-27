#require 'bundler/setup'
#Bundler.require(:default)
require './my_app'
require 'resque/tasks'

task 'resque:setup' do
  ENV['QUEUE'] = '*'
end

desc 'alias for resque:work to run workers on heroku?'
task 'jobs:work' => 'resque:work'