class Page
  include PaperTrail::Model

  include Mongoid::Document
  
  field :number,  :type => Integer, :default => 0
  field :title,   :type => String
  field :text,    :type => String  
  
  has_paper_trail

  after_create :sequence

  def sequence
    Page.next! self
  end
  
  class << self
    attr_accessor :number
    
    def next! obj
      @number ||= 0
      @number += 1
      obj.number = number 
    end
  end
end