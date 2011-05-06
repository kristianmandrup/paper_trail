# Adds a #find_next_version method to the Mongoid versioning module

module Mongoid
  module Versioning
    extend ActiveSupport::Concern
    
    def find_next_version 
      next_version = version + 1
      self.class.any_of({:version => next_version}, {:version => nil }).first
    end
  end
end
    