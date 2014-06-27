require "shortlink/version"
require 'active_support'
require 'active_record'

module Shortlink
  extend ::ActiveSupport::Concern

  module ClassMethods
    def permalink column_name, options={}
      define_method :set_permalink do
        sequence = self.class.generate_permalink

        while self.class.exists?(column_name => sequence) 
          sequence = self.class.generate_permalink
        end
        
        self.send("#{column_name}=", sequence)
      end

      before_create :set_permalink
    end

    def generate_permalink
      puts("WE R HERE")
      #puts self.inspect
      chars = [('a'..'z'), ('A'..'Z'), (0..9)].flat_map(&:to_a)
      chars.sample(6).join
    end  
  end
end

=begin
module Shortlink
  extend ActiveSupport::Concern

  module ClassMethods
    def permalink column_name, options = {}
      cattr_accessor :permalink_field
      self.permalink_field = column_name

      include Shortlink::LocalInstanceMethods
      before_validation :set_permalink
    end

    def generate_permalink
      chars = [('a'..'z'), ('A'..'Z'), (0..9)].flat_map(&:to_a)
      chars.sample(6).join
    end
  end

  module LocalInstanceMethods
    def set_permalink
      sequence = self.class.generate_permalink

      while self.class.exists?(self.class.permalink_field => sequence) 
        sequence = self.class.generate_permalink
      end
      
      self.send("#{self.class.permalink_field}=", sequence)
    end
  end
end
=end
ActiveRecord::Base.send(:include, Shortlink)