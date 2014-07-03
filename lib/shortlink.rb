require "shortlink/version"
require 'active_support'
require 'active_record'

module Shortlink
  extend ActiveSupport::Concern

  module ClassMethods
    DEFAULT_SETTINGS = { length: 6, prefix: nil }

    def shortlink column_name, options = {}
      include Shortlink::LocalInstanceMethods

      settings = options.merge(DEFAULT_SETTINGS).extract!(*DEFAULT_SETTINGS.keys)

      before_validation { set_shortlink(column_name, settings) }
    end 
  end

  module LocalInstanceMethods
    def set_shortlink shortlink_field, options
      sequence = generate_shortlink(options[:length], options[:prefix])

      while self.class.exists?(shortlink_field => sequence) 
        sequence = generate_shortlink(options[:length], options[:prefix])
      end
      
      self.send("#{shortlink_field}=", sequence)
    end

    def generate_shortlink length, prefix
      chars = [('a'..'z'), ('A'..'Z'), (0..9)].flat_map(&:to_a)
      prefix ? "#{prefix}-#{chars.sample(length).join}": chars.sample(length).join
    end   
  end
end

ActiveRecord::Base.send(:include, Shortlink)