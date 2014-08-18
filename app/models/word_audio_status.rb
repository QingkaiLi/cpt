class WordAudioStatus < ActiveRecord::Base
  validates :spelling, presence: true, length: { maximum: 255 }, :uniqueness => {:scope => :audio_id}
  validates :description, length: { maximum: 1024 }
  
  before_create :create_audio
  before_validation :init_audio_status
  before_validation :enabled_must_approved_first
  
  belongs_to :audio_status
  belongs_to :audio
  has_many :words
  belongs_to :user
  
  def change_status status_name
    self.audio_status = AudioStatus.find_by_name status_name
  end
  
  def update_with_status status_name, params
      self.audio_status = AudioStatus.find_by_name status_name unless status_name.nil?
      WordAudioStatus.transaction do
        if status_name == AudioStatus::AUDIO_STATUS_MISSING
          self.audio = Audio.create! unless (self.audio.word_audio_statuses.size <= 1)
        end
        self.update params
      end
    rescue
      false
  end

  private
    def init_audio_status
      self.audio_status ||= AudioStatus.missing
    end
    
    def enabled_must_approved_first
      self.enabled = false if self.audio_status.name.eql? AudioStatus::AUDIO_STATUS_MISSING
      
      if self.enabled
        self.audio_status.name.eql? AudioStatus::AUDIO_STATUS_APPROVED
      else
        true
      end
    end
    
    def create_audio
      audio.save!
      self.audio_status ||= AudioStatus.missing
      self.enabled ||= false
      self.audio = audio
    end
end