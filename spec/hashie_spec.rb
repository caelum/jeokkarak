require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hashie::CustomHash do
  
  context "when creating an object from a hash" do
    it "should allow direct attribute access" do
      hash = {"name" => "guilherme silveira"}
      Hashie.to_object(hash).name.should == ("guilherme silveira")
    end
    it "should allow direct attribute attribution" do
      hash = {"name" => "guilherme silveira"}
      Hashie.to_object(hash).name = "donizetti"
      Hashie.to_object(hash).name.should == ("donizetti")
    end
    it "should allow access to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Hashie.to_object(hash).player.name.should == ("guilherme silveira")
    end
    it "should allow access attribution to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      Hashie.to_object(hash).player.name = "donizetti"
      Hashie.to_object(hash).player.name.should == ("donizetti")
    end
    it "should allow access to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Hashie.to_object(hash).player[1].name.should == ("caue guerra")
    end
    it "should allow access attribution to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      Hashie.to_object(hash).player[1].name = "donizetti"
      Hashie.to_object(hash).player[1].name.should == ("donizetti")
    end
  end
  
end