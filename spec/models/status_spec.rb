require 'spec_helper'

describe Status do

  it "should be valid given valid attributes" do
    build(:status).should be_valid
  end

  describe "name attribute" do
    it "should be present" do
      build(:status).should respond_to(:name)
    end

    it "should not be nil" do
      build(:status, name: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:status, name: "").should_not be_valid
    end

    it "should be unique name" do
      u = create :status, name: Faker::Name.name
      build(:status, name: u.name).should_not be_valid
    end
  end
end
