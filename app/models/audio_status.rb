class AudioStatus < ActiveRecord::Base
  AUDIO_STATUS_MISSING = 'No Audio File'
  AUDIO_STATUS_NEEDS_REVIEW = 'Needs Review'
  AUDIO_STATUS_APPROVED = 'Approved'
  
  scope :missing, -> { where(name: AUDIO_STATUS_MISSING).take }
  scope :needs_review, -> { where(name: AUDIO_STATUS_NEEDS_REVIEW).take }
  scope :approved, -> { where(name: AUDIO_STATUS_APPROVED).take }
end
