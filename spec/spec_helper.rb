require 'shortlink'
require 'active_support'
require 'active_record'

RSpec.configure do |config|
end

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
load 'support/schema.rb'
require 'support/models.rb'