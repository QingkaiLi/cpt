class Pronunciation < ActiveRecord::Base
  validates :dictionary_key, :presence => true, :length => {:maximum => 255}
  validates :phonemes, :length => {:maximum => 512}
  validates :pronunciation_status_id, :presence => true

  before_validation :ensure_phonemes_format
  before_validation :init_status
  before_save :convert_phonemes

  belongs_to :pronunciation_status
  belongs_to :user

  VALID_PHONEMES = ['AA', 'AE', 'AH', 'AO', 'AW', 'AY', 'B', 'CH', 'D', 'DH', 'EH',
                    'ER', 'EY', 'F', 'G', 'HH', 'IH', 'IY', 'JH', 'K', 'L', 'M', 'N','NG',
                    'OW', 'OY', 'P', 'R', 'S', 'SH', 'T', 'TH', 'UH', 'UW', 'V', 'W', 'Y', 'Z', 'ZH']

  def self.search(search, filter)
    if search || filter
      if search != '' && filter.to_i == 0
        where("dictionary_key like ?", "%#{search}%")
      elsif search == '' && filter.to_i > 0
        where("pronunciation_status_id = ?", "#{filter}")
      elsif search == '' && filter.to_i == 0
        all
      else
        where("dictionary_key like ? and pronunciation_status_id = ?", "%#{search}%", "#{filter}")
      end
    else
      all
    end
  end
  
  private
    def convert_phonemes
      if !self.phonemes.nil? && self.phonemes.index(',')
        Pronunciation.where(dictionary_key: self.dictionary_key).where.not(id: self.id).destroy_all
        arr = self.phonemes.split(',')
        arr[1..-1].each{
          |phoneme| Pronunciation.create(self.attributes.merge(id: nil, phonemes: phoneme))
        }
        self.phonemes = arr[0]
      end
    end
    
    def init_status
      self.pronunciation_status ||= PronunciationStatus.missing
    end
    
    def ensure_phonemes_format
      self.phonemes.gsub(/[,]/,'').split(' ').reduce(true) {|valid, p| valid &&= !VALID_PHONEMES.index(p).nil?} || self.phonemes == '' unless self.phonemes.nil?
    end
end
