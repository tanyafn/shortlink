class TestModel < ActiveRecord::Base
  shortlink :shortlink
  shortlink :configured_shortlink, length: 9, prefix: 'prefix'
end
