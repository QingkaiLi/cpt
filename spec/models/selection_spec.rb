require 'spec_helper'

describe Selection do
  describe "status association" do
    it "should be present" do
      build(:selection).should respond_to(:status)
    end

    it "should not be nil" do
      build(:selection, status_id: nil).should be_valid
    end
  end

  describe "updater association" do
    it "should be present" do
      build(:selection).should respond_to(:updater)
    end

    it "should not be nil" do
      build(:selection, updater_id: nil).should_not be_valid
    end
  end

  it "should be valid given valid attributes" do
    build(:selection).should be_valid
  end
  
  describe "title attribute" do
    it "should be present" do
      build(:selection).should respond_to(:title)
    end

    it "should not be nil" do
      build(:selection, title: nil).should_not be_valid
    end

    it "should not be blank" do
      build(:selection, title: "").should_not be_valid
    end

    it "should be unique within one Content Pack" do
      s = create :selection
      build(:selection, title: s.title, topic: s.topic).should_not be_valid
    end
    
    it "can be the same between two Content Packs" do
      s = create :selection
      c = create :content_pack
      build(:selection, title: s.title, topic: c.default_topic).should be_valid
    end

    it "should be case sensitive" do
      s = create :selection
      create(:selection, title: s.title.upcase).should be_valid
    end

    it "should be less than 256 characters" do
      title = Faker::Lorem.characters 256
      x = create(:selection, title: title)
      x.should be_valid
      x.title.should == title
      title = Faker::Lorem.characters 257
      expect { create :selection, title: title}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "description attribute" do
    it "should be present" do
      build(:selection).should respond_to(:description)
    end

    it "should be less than 1024 characters" do
      description = Faker::Lorem.characters 1024
      x = create(:selection, description: description)
      x.should be_valid
      x.description.should == description
      description = Faker::Lorem.characters 1025
      expect { create :selection, description: description}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  describe "updated_at attribute" do
    it "should be present" do
      build(:selection).should respond_to(:updated_at)
    end
  end
  
  describe "grade_equivalent_level" do
    it "should be present" do
      build(:selection).should respond_to(:grade_equivalent_level)
    end
  end
  
  describe "wcpm_target" do
    it "should be numeric value" do
      build(:selection, wcpm_target: 'aaa').should_not be_valid
    end
    
    it "should within [1, 999]" do
      build(:selection, wcpm_target: 0).should_not be_valid
      build(:selection, wcpm_target: 1).should be_valid
      build(:selection, wcpm_target: 999).should be_valid
      build(:selection, wcpm_target: 1000).should_not be_valid
    end
    
    it "should be integer value" do
      build(:selection, wcpm_target: 10.01).should_not be_valid
    end
    
    it "can be blank" do
      build(:selection).should be_valid
    end
  end
  
  describe "author" do
    it "can be blank" do
      build(:selection).should be_valid
    end
    
    it "should be less than 256 characters" do
      author = Faker::Lorem.characters 256
      x = create(:selection, author: author)
      x.should be_valid
      x.author.should == author
      author = Faker::Lorem.characters 257
      expect { create :selection, author: author}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  describe "publisher" do
    it "can be blank" do
      build(:selection).should be_valid
    end
    
    it "should be less than 256 characters" do
      publisher = Faker::Lorem.characters 256
      x = create(:selection, publisher: publisher)
      x.should be_valid
      x.publisher.should == publisher
      publisher = Faker::Lorem.characters 257
      expect { create :selection, publisher: publisher}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  describe "illustrator" do
    it "should be less than 256 characters" do
      illustrator = Faker::Lorem.characters 256
      x = create(:selection, illustrator: illustrator)
      x.should be_valid
      x.illustrator.should == illustrator
      illustrator = Faker::Lorem.characters 257
      expect { create :selection, illustrator: illustrator}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  describe "intro_audio" do
    it "can be blank" do
      build(:selection).should be_valid
    end
    
    it "should be less than 1024 characters" do
      intro_audio = Faker::Lorem.characters 1024
      x = create(:selection, intro_audio: intro_audio)
      x.should be_valid
      x.intro_audio.should == intro_audio
      intro_audio = Faker::Lorem.characters 1025
      expect { create :selection, intro_audio: intro_audio}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  describe "intro_text" do
    it "can be blank" do
      build(:selection).should be_valid
    end
    
    it "should be less than 1024 characters" do
      intro_text = Faker::Lorem.characters 1024
      x = create(:selection, intro_text: intro_text)
      x.should be_valid
      x.intro_text.should == intro_text
      intro_text = Faker::Lorem.characters 1025
      expect { create :selection, intro_text: intro_text}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  describe "internationally" do
    it "should be present" do
      build(:selection).should respond_to(:internationally)
    end
  end
end
