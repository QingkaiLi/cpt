require 'spec_helper'

describe ContentType do

  it "should be valid given valid attributes" do
    build(:content_type).should be_valid
  end

  describe "name attribute" do
    it "should be present" do
      build(:content_type).should respond_to(:name)
    end

    it "should not be nil" do
      build(:content_type, name: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:content_type, name: "").should_not be_valid
    end

    it "should be unique name" do
      u = create :content_type, name: Faker::Name.name
      build(:content_type, name: u.name).should_not be_valid
    end
  end
end
