class GlueWordsController < ApplicationController
  def new
    render :layout => false
  end

  # POST /glue_words/upload
  def upload
    glue_words = []
    file = params[:file]
    filename = file.original_filename
    if !filename.empty?
      if !(/.txt$/.match(filename).nil?)
        file.read.gsub(/\r\n?/, "\n").each_line{ |line|
          glue_words << GlueWord.new do |u|
                        u.grade_level = filename[0..-5]
                        u.word = line.strip
                      end
        }
      end
    end
    
    GlueWord.batch_save glue_words
  end
end
