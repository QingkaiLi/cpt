@scilearn.word =
  init: ->
    jQuery ->
      # click the status icon to open the dialog
      $('#words_list').on('click', '.word-status', (e) ->
        e.preventDefault()
        if $(@).is('.no-audio-file')
          # show upload audio dialog
          scilearn.word.edit @.href
        else
          #show audio playback dialog
          scilearn.word.show @.href, @.className
      )
      # dblclick to edit the description
      .on('dblclick', '.desc', ->
        scilearn.word.showEditDesc $(@)
      )
      # bind enter button click fn when edit the description
      .on('keydown', 'input:text', (e) ->
        if e.keyCode is 13
          scilearn.word.editDesc $(@)
          e.preventDefault()

        if e.keyCode is 27
          scilearn.word.hideEditDesc $(@)
          $(@).remove()


      )
      # bind blur fn when edit the description
      .on('blur', 'input:text', ->
        scilearn.word.editDesc($(@))
      )
      .on('change','#per_page', ->
        $('#filter').val $('#filter_text').val()
        $('#search_text').val $('#keyword').val()
        $('#words_form').submit()
      )
      .on('click', '.dataTables_paginate a', ->
        $.getScript @href
        false
      )
      .on 'click', 'input:checkbox', ->
        enable = !!$(@).prop('checked')
        url = $(@).parents('tr').find('td:first a').prop('href')
        scilearn.word.saveEnabled url, enable

      # form submit
      $('#words_form').submit ->
        $.get @action, $(@).serialize(), ->
          $('.word-status').qtip()
        , "script"
        false

      # on change filter
      $('#filter').bind 'change', ->
        $('#search_text').val $('#keyword').val()
        $('#words_form').submit()

      # clear search
      $('#clear_search').click ->
        $('#search_text').val ''
        $('#filter').val $('#filter_text').val()
        $('#words_form').submit()
        false

      # clear filter
      $('#clear_filter').click ->
        $('#filter').val ''
        $('#search_text').val $('#keyword').val()
        $('#words_form').submit()

      # quick search
      $('#search_text').keydown (e)->
        $('#words_form').submit() if e.keyCode is 13

      $('.word-status').qtip()


  playAudio: ->
    $('#audio').bind 'ended', (e) ->
      $('.play-icon').removeClass('stop')
    $('.play-icon').click ->
      $(@).toggleClass('stop')
      if $(@).hasClass('stop')
        $('#audio')[0].play()
      else
        $('#audio')[0].pause()

  hideEditDesc: ($element) ->
    $element.hide().parent().removeClass 'edit pure-form'

  showEditDesc: ($element) ->
    if !$element.hasClass 'edit'
      $input = $('<input/>').prop('type','text')
      $input.val $element.text()
      $element.addClass('pure-form edit').append($input)
      $input.focus()

  editDesc: ($element) ->
    desc = $element.val()
    href = $element.parents('tr').find('td:first a').prop('href')
    scilearn.word.saveDescription href, desc
    scilearn.word.hideEditDesc $element

  edit: (url) ->
    $.ajax
      url: url + "/edit"
      type: "GET"
      success: (data) ->
        scilearn.word.showEditDialog data, url
      error: (xhr, type) ->
        scilearn.notification.error 'get word audio status with error'

  show: (url) ->
    $.ajax
      url: url
      type: "GET"
      success: (data) ->
        scilearn.word.showAudioPlaybackDialog url, data
      error: (xhr, type) ->
        scilearn.notification.error 'get word audio status with error'

  showEditDialog: (data, url) ->
    scilearn.panel.edit = art.dialog(
      title: "Import Audio"
      content: data
      width: 500
      button: [
        {
          name: 'Continue'
          className: "pure-button pure-button-small pure-button-disabled import-continue"
          callback: ->
            false
        },
        {
          name: 'Cancel'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]
    )
    $('#import_audio').on 'click', '.browse-file', (e) ->
      $('#audio_file_upload').click()
    scilearn.word.fileUpload url

  fileUpload: (url) ->
    $('#audio_file_upload').fileupload
      dataType: 'json'
      maxNumberOfFiles : 1
      acceptFileTypes:  /(\.|\/)(mp3)$/i
      add: (e, data) ->
        file = data.originalFiles[0]
        $('#audio_file_upload_display').text file.name
        #156KB
        if file.name == $('#import_audio .file-name').text() && file.size <= 156000
          $('.import-continue', $(this).parents('tbody')).addClass('pure-button-success').removeClass('pure-button-disabled')
          $('.alert-explanation').text ''
        else
          errorMsg = ''
          if file.name != $('#import_audio .file-name').text()
            errorMsg = "File name do not match. Please choose the matching file."
          if file.size > 156000
            errorMsg += "<br>File size should less than 156KB. Please choose the matching file."
          $('.import-continue', $(this).parents('tbody')).addClass('pure-button-disabled').removeClass('pure-button-success')
          $('.alert-explanation').html errorMsg

        $('.pure-button-success').click ->
          jqXHR  = data.submit()
            .success (result, textStatus, jqXHR) ->
              scilearn.word.show url
              scilearn.panel.edit.close()
              $('.word-status', '#word_' + url.substring(url.lastIndexOf('/') + 1) ).attr('class', 'word-status needs-review')
            .error (jqXHR, textStatus, errorThrown) ->
              scilearn.notification.error "error"
      progress: (e, data) ->
        $('.aui_buttons').hide()
        scilearn.panel.edit.content("Please wait...<br><br><br><br>")

  showAudioPlaybackDialog: (url, data)->
    btns = []
    if data.indexOf('Approved') < 0
      btns.push
        focus: true
        name: 'Approve Audio'
        className: "pure-button pure-button-small pure-button-success"
        callback: ->
          scilearn.word.approveAudio url
          true
    btns.push
      name: 'Reject Audio'
      className: "pure-button pure-button-small pure-button-success"
      callback: ->
        scilearn.word.showRejectAudio url, $('.word-spelling').html()
        true

    scilearn.panel.audioPlayback = art.dialog(
      width: 450
      title: "Audio Playback"
      content: data
      button: btns
    )

    scilearn.word.playAudio()

  approveAudio: (url) ->
    callback = (data) ->
      scilearn.word.showAudioPlaybackDialog url, data
      $('.word-status', '#word_' + url.substring(url.lastIndexOf('/') + 1) ).attr('class', 'word-status approved')
    scilearn.word.update url, {audio_status_name: 'Approved'}, callback

  rejectAudio: (url) ->
    callback = (data) ->
      $('.word-status', '#word_' + url.substring(url.lastIndexOf('/') + 1) ).attr('class', 'word-status no-audio-file')
    scilearn.word.update url, {audio_status_name: 'No Audio File'}, callback

  saveDescription: (url, desc) ->
    scilearn.word.update url, {description: desc}

  saveEnabled: (url, enable) ->
    scilearn.word.update url, {enabled: if enable then 1 else 0 }

  update: (url, data, callback) ->
    $.ajax
      url: url
      type: "PUT"
      data: { word_audio_status: data }
      success: callback

  showRejectAudio: (url, content) ->
    scilearn.panel.reject = art.dialog(
      title: "Reject Audio"
      content: "Are you sure you want to reject audio for the following: <p>#{content}<p>"
      width: 400
      button: [
        {
          name: 'Yes'
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.word.rejectAudio url
        },
        {
          name: 'No'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]
    )


