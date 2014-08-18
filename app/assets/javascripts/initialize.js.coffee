initialize = ->
  sessionStorage.clear() if !scilearn.config.cache
  switch $(document.body).attr "id"
    when "content_packs_index" then scilearn.pack.init()
    when "topics_index"
      scilearn.topic.init()
      scilearn.selection.init()
    when "word_audio_status_index" then scilearn.word.init()
    when "pronunciations_index" then scilearn.pronunciation.init()

  # close dialog button event
  $(document.body).on("click", ".actions .pure-button-cancel", ->
    id = $(@).parents('.aui_state_lock').attr 'id'
    art.dialog.list[id].close()
  )
  .click (e)->
    $('.pure-button-group',@).removeClass 'button-group-open'

  $(".pure-button-group .pure-button").click ->
    $(@).parent().toggleClass 'button-group-open'
    false

  $('#import_glue_words').click ->
    $.get @href, null, (e) ->
      scilearn.glue.showDialog e
    , "html"
    false

jQuery ->
  initialize()

if @addEventListener
  document.addEventListener "page:load", initialize
else
  document.attachEvent "onpage:load", initialize
