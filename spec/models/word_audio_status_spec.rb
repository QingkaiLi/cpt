require 'spec_helper'

describe Word do
  
  let(:word_audio_status) { FactoryGirl.create(:word_audio_status) }
  
  subject { word_audio_status }
  
  it { should respond_to(:spelling) }
  it { should respond_to(:audio_id) }
  it { should respond_to(:audio_status_id) }
  it { should respond_to(:enabled) }
  it { should respond_to(:description) }
  it { should respond_to(:words) }
  it { should respond_to(:user) }
  
  describe "when spelling attribute" do
    describe "is not present" do
      before { word_audio_status.spelling = " " }
      it { should_not be_valid }
    end
    
    describe "is nil" do
      before { word_audio_status.spelling = nil }
      it { should_not be_valid }
    end
    
    describe "is too long" do
      before { word_audio_status.spelling = "a" * 256 }
      it { should_not be_valid }
    end
    
    it "is not uniqueness composite with audio_id should not valid" do
      build(:word_audio_status, spelling: word_audio_status.spelling, audio_id: word_audio_status.audio_id).should_not be_valid
    end
  end
  
  describe "when description attribute" do
    describe "is not present" do
      before { word_audio_status.description = " " }
      it { should be_valid }
    end
    
    describe "is too long" do
      before { word_audio_status.description = "a" * 1025 }
      it { should_not be_valid }
    end
  end
end
