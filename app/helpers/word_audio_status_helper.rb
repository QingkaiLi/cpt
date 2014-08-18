module WordAudioStatusHelper
  def audio_status (id, name)
    class_name = name.gsub(/[ ]/,'-').downcase
    link_to '', word_audio_status_path(id), class: "word-status "+class_name, title: name
  end

  def enable_checkbox (word)
    if word.num.to_i > 0 && word.name == "Approved"
      check_box_tag word.spelling, 'enable', word.enabled
    end
  end

  def word_spelling (word)
    class_name = "word"
    class_name << " red" if word.color == 1
    content_tag :span, word.spelling, class: class_name
  end
end
