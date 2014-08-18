class GlueWord < ActiveRecord::Base
  before_create :create_glue_word
   
  validates :word, :word_validate, presence: true, length: { maximum: 255 } #, uniqueness: { scope: :grade_level }
  validates :grade_level, length: { maximum: 255 }, presence: true, :format => { :with => /\A(x|\d)+??(?:\.(x|\d){0,2})?\z/}
  
  def self.batch_save glue_words
      GlueWord.transaction do
        glue_words.each {
          |gw| gw.save!
        }
      end
    rescue ActiveRecord::RecordInvalid => e
      false
  end
  
  private
    def word_validate
      # words like merry-go-around/it's/U.S. all OK
      self.word && !(self.word =~ /(([a-zA-Z0-9])+(\.|')*)+-*[^-]$/).nil?
    end
    
    def create_glue_word
      GlueWord.where(grade_level: self.grade_level, word: self.word).destroy_all
    end
  
end
