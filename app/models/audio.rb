class Audio < ActiveRecord::Base
  before_validation :generate_audio_file
  before_save :init_status
  
  has_many :word_audio_statuses
  
  validates :file_name, presence: true, uniqueness: true, length: { maximum: 255 }
  
  private
    def init_status
      self.word_audio_statuses.each{ |was|
        was.audio_status = AudioStatus.needs_review
        was.save!
       } unless new_record?
    end
  
    def generate_audio_file
      self.file_name ||= Audio.find_by_sql('select uuid() uuid').first.uuid << '--audio.mp3'
    end
  
end