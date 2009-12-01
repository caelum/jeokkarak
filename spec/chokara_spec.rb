require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Product
  extend Chokara::Base
  attr_accessor :name
  attr_accessor :valid
end

describe Chokara::Base do
  
  context "when creating an object from a hash" do
    it "should create that class's object" do
      hash = {"name" => "guilherme silveira"}
      Product.to_object(hash).name.should == ("guilherme silveira")
    end
    it "should allow direct attribute access" do
      hash = {"name" => "guilherme silveira"}
      Product.to_object(hash).name.should == ("guilherme silveira")
    end
    it "should allow direct attribute attribution" do
      hash = {"name" => "guilherme silveira"}
      Product.to_object(hash).name = "donizetti"
      Product.to_object(hash).name.should == ("donizetti")
    end
    it "should allow access to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Product.to_object(hash).player.name.should == ("guilherme silveira")
    end
    it "should allow access to boolean element" do
      hash = {"player" => {"name" => "guilherme silveira", "valid" => true}}
      Product.to_object(hash).player.valid.should be_true
    end
    it "should allow access attribution to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Product.to_object(hash).player.name = "donizetti"
      Product.to_object(hash).player.name.should == ("donizetti")
    end
    it "should allow access to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Product.to_object(hash).player[1].name.should == ("caue guerra")
    end
    it "should allow access attribution to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Product.to_object(hash).player[1].name = "donizetti"
      Product.to_object(hash).player[1].name.should == ("donizetti")
    end
    
  end
  
end