require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Product
  attr_accessor :_internal_hash
  extend Chokara::Base
  attr_accessor :name
  attr_accessor :valid
  def valid?
    valid
  end
end

describe Chokara::Base do
  
  context "when creating an object from a hash" do
    it "should create that class's object" do
      hash = {"name" => "guilherme silveira"}
      product = Product.from_hash(hash)
      product.class.should eql(Product)
    end
    it "should allow direct attribute access" do
      hash = {"name" => "guilherme silveira"}
      product = Product.from_hash(hash)
      product.name.should == ("guilherme silveira")
    end
    it "should allow direct attribute attribution" do
      hash = {"name" => "guilherme silveira"}
      product = Product.from_hash(hash)
      product.name = "donizetti"
      product.name.should == ("donizetti")
    end
    it "should allow direct new attribute access" do
      hash = {"age" => 29}
      product = Product.from_hash(hash)
      product.age.should == 29
    end
    it "should allow direct new attribute attribution" do
      hash = {"age" => 28}
      product = Product.from_hash(hash)
      product.age = 29
      product.age.should == 29
    end
    it "should allow access to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      product = Product.from_hash(hash)
      product.player.name.should == ("guilherme silveira")
    end
    it "should allow access to boolean element" do
      hash = {"player" => {"name" => "guilherme silveira", "valid" => true}}
      product = Product.from_hash(hash)
      product.player.valid.should be_true
    end
    it "should allow access attribution to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      product = Product.from_hash(hash)
      product.player.name = "donizetti"
      product.player.name.should == ("donizetti")
    end
    it "should allow access to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      product = Product.from_hash(hash)
      product.player[1].name.should == ("caue guerra")
    end
    it "should allow access attribution to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      product = Product.from_hash(hash)
      product.player[1].name = "donizetti"
      product.player[1].name.should == ("donizetti")
    end
        
  end
  
end