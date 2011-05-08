require 'spec_helper'

describe Book do

  before (:each) do
    @book = Book.create(:language => 'thai', :category => 1, :volume => 1, :title => 'foo bar')
  end

  it "should have a title attribute" do
    @book.should respond_to(:title) 
  end

  it "should have a language attribute" do
    @book.should respond_to(:language)
  end
  
  it "should have a category attribute" do
    @book.should respond_to(:category)
  end

  it "should have a volume attribute" do
    @book.should respond_to(:volume)
  end
end
