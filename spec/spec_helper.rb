require 'rspec'
require 'mongoid'
require 'paper_trail'
require 'mongoid_geo'
                 
Mongoid.configure.master = Mongo::Connection.new.db('paper-trail')

Mongoid.database.collections.each do |coll|
  coll.remove
end

require 'model/page'

RSpec.configure do |config|
  config.before do
    Mongoid.database.collections.each do |coll|
      coll.remove
    end      
  end
  config.after do
    Mongoid.database.collections.each do |coll|
      coll.remove
    end      
  end
end


