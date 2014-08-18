class Word < ActiveRecord::Base
  before_save {self.text = text.downcase }
  before_create :create_audio_associate
  
  belongs_to :word_audio_status
  
  validates :text, presence: true, length: { maximum: 255 }
  validates :alt_text, length: { maximum: 1024 }
  
  attr_accessor :audio
  
  private
    def create_audio_associate
      self.audio ||= Audio.new
      self.word_audio_status = WordAudioStatus.create_with(audio: self.audio)
                                          .find_or_create_by(spelling: text, audio_id: audio.id)
    end
end
