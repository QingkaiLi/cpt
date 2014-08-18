require 'spec_helper'

describe User do

  it "should be valid given valid attributes" do
    build(:user).should be_valid
  end

  describe "provider attribute" do
    it "should be present" do
      build(:user).should respond_to(:provider)
    end

    it "should not be nil" do
      build(:user, provider: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:user, provider: "").should_not be_valid
      5.times do
        build(:user, provider: " " * Random.rand(255)).should_not be_valid
      end
    end

    it "should not be longer than 255 characters" do
      build(:user, provider: "a" * 255).should be_valid
      build(:user, provider: "a" * 256).should_not be_valid
    end

  end

  describe "uid attribute" do
    it "should be present" do
      build(:user).should respond_to(:uid)
    end

    it "should not be nil" do
      build(:user, uid: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:user, uid: "").should_not be_valid
      5.times do
        build(:user, uid: " " * Random.rand(255)).should_not be_valid
      end
    end

    it "should not be longer than 255 characters" do
      build(:user, uid: "a" * 255).should be_valid
      build(:user, uid: "a" * 256).should_not be_valid
    end

    it "should be unique per provider" do
      u = create :user, provider: Faker::Company.name, uid: "#{(Time.zone.now - 1.minute).to_i}"
      build(:user, provider: u.provider, uid: u.uid).should_not be_valid
      build(:user, provider: u.provider, uid: "#{Time.zone.now.to_i}").should be_valid
      build(:user, provider: Faker::Company.name, uid: u.uid).should be_valid
    end
  end

  describe "name attribute" do
    it "should be present" do
      build(:user).should respond_to(:name)
    end

    it "should not be nil" do
      build(:user, name: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:user, name: "").should_not be_valid
    end

    it "should not be longer than 255 characters" do
      build(:user, name: "a" * 255).should be_valid
      build(:user, name: "a" * 256).should_not be_valid
    end
  end
end
