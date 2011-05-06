require 'spec_helper'

describe PaperTrail do
  it 'should be a Module' do
    PaperTrail.should be_a(Module)    
  end

  context 'A single page' do
    before :each do
      @page = Page.create
    end

    describe '#version' do
      it 'should initially be number 1' do
        @page.number.should == 1
      end 
    end

    describe '#previous' do
      it 'should return the first version - number 1' do
        @page.previous.number.should == 1
      end 
    end

    describe '#next' do
      it 'should return the first version - number 1' do
        @page.next.number.should == 1
      end 
    end
  end

  context '2 pages' do
    before :each do
      @page1 = Page.create
      @page2 = Page.create
    end

    describe '#version' do
      it 'should initially have numbers 1 and 2' do
        @page1.number.should == 1
        @page2.number.should == 2
      end 
    end

    describe '#previous of page 2' do
      it 'should return page 1' do
        @page2.previous.number.should == 1
      end 
    end

    describe '#next of page 1' do
      it 'should return page 2' do
        @page1.next.number.should == 2
      end 
    end

    describe '#reify of page 2' do
      it 'should return page 1 as current version' do
        @page2.title = 'Changed it' # must be changed first in order to be revisable !!!
        @page2.reify.number.should == 1
        Page.last.number.should == 1
      end 
    end

    describe 'versions destroyed' do
      it 'should destroy top version each time' do
        @page2.title = 'Changed it again'
        @page2.reify.number.should == 1 # numbers: 1,2,1

        Page.last.number.should == 1
        Page.last.destroy # numbers: 1,2
        Page.last.number.should == 2
        Page.last.destroy # numbers: 1
        Page.last.number.should == 1
      end 
    end
  end
end
  