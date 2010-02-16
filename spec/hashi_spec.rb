require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hashi::CustomHash do
  
  context "when creating an object from a hash" do
    it "should allow direct attribute access" do
      hash = {"name" => "guilherme silveira"}
      Hashi.to_object(hash).name.should == ("guilherme silveira")
    end
    
    it "should allow direct attribute attribution" do
      hash = {"name" => "guilherme silveira"}
      Hashi.to_object(hash).name = "donizetti"
      Hashi.to_object(hash).name.should == ("donizetti")
    end
    
    it "should allow access to nil attribute" do
      hash = {"name" => nil}
      Hashi.to_object(hash).name.should be_nil
    end
    it "should allow access to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Hashi.to_object(hash).player.name.should == ("guilherme silveira")
    end
    it "should allow access to boolean element" do
      hash = {"player" => {"name" => "guilherme silveira", "valid" => true}}
      Hashi.to_object(hash).player.valid.should be_true
    end
    it "should allow access attribution to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Hashi.to_object(hash).player.name = "donizetti"
      Hashi.to_object(hash).player.name.should == ("donizetti")
    end
    it "should allow access to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Hashi.to_object(hash).player[1].name.should == ("caue guerra")
    end

    it "should allow direct access to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Hashi.to_object(hash)[1].name.should == ("caue guerra")
    end

    it "should allow access attribution to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Hashi.to_object(hash).player[1].name = "donizetti"
      Hashi.to_object(hash).player[1].name.should == ("donizetti")
    end
    
    it "should respond to existing attributes" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Hashi.to_object(hash).respond_to?(:player).should be_true
    end
    
    it "should be able to hand out an array size" do
      hash = [5, 7]
      Hashi.to_object(hash).length.should == 2
    end
    
    it "should be able to iterate over array" do
      hash = [{"oi" => :hello}, {"oi" => :sorry}]
      found = []
      Hashi.to_object(hash).each do |key|
        found << key.oi
      end
      found.length.should be(2)
      found[0].should == hash[0]["oi"]
      found[1].should == hash[1]["oi"]
    end
    
  end
  
end