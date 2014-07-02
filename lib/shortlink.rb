require "shortlink/version"
require 'active_support'
require 'active_record'

module Shortlink
  extend ActiveSupport::Concern

  module ClassMethods
    def shortlink column_name, options = {}
      cattr_accessor :shortlink_field
      self.shortlink_field = column_name

      include Shortlink::LocalInstanceMethods
      before_validation :set_shortlink
    end

    def generate_shortlink
      chars = [('a'..'z'), ('A'..'Z'), (0..9)].flat_map(&:to_a)
      chars.sample(6).join
    end
  end

  module LocalInstanceMethods
    def set_shortlink
      sequence = self.class.generate_shortlink

      while self.class.exists?(self.class.shortlink_field => sequence) 
        sequence = self.class.generate_shortlink
      end
      
      self.send("#{self.class.shortlink_field}=", sequence)
    end
  end
end
ActiveRecord::Base.send(:include, Shortlink)