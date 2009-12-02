require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Player
  attr_accessor :_internal_hash
  acts_as_jeokkarak
  attr_accessor :name
  attr_accessor :valid
  def valid?
    valid
  end
end

class Team
  attr_accessor :_internal_hash
  acts_as_jeokkarak
  has_child Player, :as => "player"
end

describe Jeokkarak::Base do
  
  context "when creating an object from a hash" do
    it "should create that class's object" do
      hash = {"name" => "guilherme silveira"}
      player = Player.from_hash(hash)
      player.class.should eql(Player)
    end
    it "should allow direct attribute access" do
      hash = {"name" => "guilherme silveira"}
      player = Player.from_hash(hash)
      player.name.should == ("guilherme silveira")
    end
    it "should allow direct attribute attribution" do
      hash = {"name" => "guilherme silveira"}
      player = Player.from_hash(hash)
      player.name = "donizetti"
      player.name.should == ("donizetti")
    end
    it "should allow direct new attribute access" do
      hash = {"age" => 29}
      player = Player.from_hash(hash)
      player.age.should == 29
    end
    it "should allow direct new attribute attribution" do
      hash = {"age" => 28}
      player = Player.from_hash(hash)
      player.age = 29
      player.age.should == 29
    end
    it "should allow access to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      team = Team.from_hash(hash)
      team.player.class.should eql(Player)
      team.player.name.should == ("guilherme silveira")
    end
    it "should allow access to boolean element" do
      hash = {"player" => {"name" => "guilherme silveira", "valid" => true}}
      team = Team.from_hash(hash)
      team.player.valid.should be_true
    end
    it "should allow access attribution to child element" do
      hash = {"player" => {"name" => "guilherme silveira"}}
      team = Team.from_hash(hash)
      team.player.name = "donizetti"
      team.player.name.should == ("donizetti")
    end
    it "should allow access to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      team = Team.from_hash(hash)
      team.player[0].class.should eql(Player)
      team.player[1].class.should eql(Player)
      team.player[1].name.should == ("caue guerra")
    end
    it "should allow access attribution to an array element" do
      hash = {"player" => [{"name" => "guilherme silveira"}, {"name" => "caue guerra"}]}
      team = Team.from_hash(hash)
      team.player[1].name = "donizetti"
      team.player[1].name.should == ("donizetti")
    end
    it "should invoke the original method_missing if there is no attribute with that nem" do
      hash = {}
      team = Team.from_hash(hash)
      team.should_receive(:method_missing).with(:whatever)
      team.whatever
    end
        
  end
  
end