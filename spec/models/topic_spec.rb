require 'spec_helper'

describe Topic do

  describe "content_pack association" do
    it "should be present" do
      build(:topic).should respond_to(:content_pack)
    end

    it "should not be nil" do
      expect {create(:topic, content_pack_id: nil)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "should be valid given valid attributes" do
    build(:topic).should be_valid
  end
  
  describe "name attribute" do
    it "should be present" do
      build(:topic).should respond_to(:name)
    end

    it "should not be nil" do
      build(:topic, name: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:topic, name: "").should_not be_valid
    end

    it "should be unique" do
      c = create :topic
      build(:topic, name: c.name).should_not be_valid
    end

    it "should be case sensitive" do
      c = create :topic
      create(:topic, name: c.name.upcase).should be_valid
    end

    it "should be at most 256 characters long" do
      name = Faker::Lorem.characters 256
      x = create(:topic, name: name)
      x.should be_valid
      x.name.should == name
      name = Faker::Lorem.characters 257
      expect { create :topic, name: name}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "grade_level attribute" do
    it "should be present" do
      build(:topic).should respond_to(:grade_level)
    end

    it "should not be nil" do
      build(:topic, grade_level: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:topic, grade_level: "").should_not be_valid
    end

    it "should not be numericality" do
      build(:topic, grade_level: "1.1w").should_not be_valid
    end
    
    it "should not be less_than 101" do
      build(:topic, grade_level: 101).should_not be_valid
      build(:topic, grade_level: 99.0).should be_valid
    end
    
    it "should not be greater than or equal to 1" do
      build(:topic, grade_level: 1).should be_valid
      build(:topic, grade_level: 0).should_not be_valid
    end
  end

  describe "default attribute" do
    it "should be present" do
      build(:topic).should respond_to(:default)
    end

    it "should not be nil" do
      build(:topic, default: nil).should be_valid
    end

    it "should not be blank" do
      build(:topic, default: "").should be_valid
    end
  end
  
  describe "topic empty?" do
    before(:each) do
      @c = create(:topic)
    end
    
    it "should be true if has no selections" do
      @c.should be_empty
    end

    it "should be false if has selections" do
      s = create(:selection, topic: @c)
      @c.should be_empty
    end
  end
  
  describe "generate default name" do
    it "should be start with 'default_topic_'" do
      Topic.generate_def_name.should match(/^default_topic_/)
    end
  end
end
