require 'spec_helper'

describe ContentPack do

  it "should be valid given valid attributes" do
    build(:content_pack).should be_valid
  end

  describe "name attribute" do
    it "should be present" do
      build(:content_pack).should respond_to(:name)
    end

    it "should not be nil" do
      build(:content_pack, name: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:content_pack, name: "").should_not be_valid
    end
    
    it "should be case sensitive" do
      c = create :content_pack
      create(:content_pack, name: c.name.upcase).should be_valid
    end

    it "should be at most 256 characters long" do
      name = Faker::Lorem.characters 256
      x = create(:content_pack, name: name)
      x.should be_valid
      x.name.should == name
      name = Faker::Lorem.characters 257
      expect { create :content_pack, name: name}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should be unique" do
      c = create :content_pack
      build(:content_pack, name: c.name).should_not be_valid
    end
  end

  describe "description attribute" do  
    it "should be case sensitive" do
      c = create :content_pack
      build(:content_pack, description: c.description.upcase).should be_valid
      build(:content_pack, description: c.description.downcase).should be_valid
    end

    it "should be less than 1024 characters" do
      build(:content_pack, description: "a" * 1024).should be_valid
      build(:content_pack, description: "a" * 1025).should_not be_valid
    end
  end

  describe "user association" do
    it "should be present" do
      build(:content_pack).should respond_to(:user)
    end

    it "should not be nil" do
      build(:content_pack, user_id: nil).should_not be_valid
    end
  end

  describe "content_type association" do
    it "should be present" do
      build(:content_pack).should respond_to(:content_type)
    end

    it "should not be nil" do
      build(:content_pack, content_type_id: nil).should be_valid
    end
  end

  describe "status association" do
    it "should be present" do
      build(:content_pack).should respond_to(:status)
    end

    it "should not be nil" do
      build(:content_pack, status_id: nil).should be_valid
    end
  end
  
  describe "get default topic" do
    before(:each) do
      @c = create :content_pack
    end
    it "should eq default topic" do
       @c.default_topic.default.should be_true
    end
  end
  
  describe "content pack published?" do
    it "published" do
      c = create :content_pack
      p = c.status.name.eql? "Published"
      expect(c.published?).to eq(p)
    end
  end

  describe "content pack empty?" do
    it "should be true if only has topic" do
      c = create :content_pack
      create(:topic, content_pack: c)
      expect(c.empty?).to eq(true)
    end

    it "should be false if has selections" do
      c = create :content_pack
      create :selection, topic: c.default_topic
      expect(c.empty?).to eq(false)
    end
  end

  describe "content pack create default topic" do
    it "should be true" do
      c = create :content_pack
      t = c.topics.first
      expect(t.default).to eq(true)
    end
  end

  describe "when being destroyed" do
    before {@cp = create :content_pack}

    it "should succeed if it is empty" do
      @cp.should be_empty
      @cp.destroy.should be_true
      @cp.should be_destroyed
    end

    it "should fail if it is not empty" do
      topic = @cp.topics.create attributes_for :topic
      topic.selections.create attributes_for :selection
      @cp.should_not be_empty
      @cp.destroy.should be_false
    end

    it "should destroy all the associated topics" do
      @cp.topics.count.should > 0
      @cp.destroy.should be_true
      @cp.topics.each {|t| t.should be_destroyed}
    end
  end
end
