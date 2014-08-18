require 'spec_helper'

describe Audio do
  
  let(:audio) { FactoryGirl.create(:audio) }
  
  subject { audio }
  
  it { should respond_to(:file_name) }
  it { should respond_to(:audio) }
  it { should respond_to(:version) }
  it { should respond_to(:word_audio_statuses) }
  
  describe "when file_name attribute" do
    describe "is not present" do
      before { audio.file_name = " " }
      it { should_not be_valid }
    end
    
    describe "is nil" do
      before { audio.file_name = nil }
      it { should be_valid }
    end
    
    describe "is too long" do
      before { audio.file_name = "a" * 256 }
      it { should_not be_valid }
    end
  end
end
