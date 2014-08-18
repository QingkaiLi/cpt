class PronunciationStatus < ActiveRecord::Base
  PRO_STATUS_MISSING = 'Missing Pronunciation'
  PRO_STATUS_NEEDS_REVIEW = 'Needs Review'
  PRO_STATUS_APPROVED = 'Approved'
  
  scope :missing, -> { where(name: PRO_STATUS_MISSING).take }
  scope :needs_review, -> { where(name: PRO_STATUS_NEEDS_REVIEW).take }
  scope :approved, -> { where(name: PRO_STATUS_APPROVED).take }
end
