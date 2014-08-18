@scilearn.pronunciation =
  init: ->
    jQuery ->
      $('#pronunciation_form').on('click', '.needs-review', (e) ->
        e.preventDefault()
        scilearn.pronunciation.showReviewDialog scilearn.pronunciation.getPronunciationId($(@)), $('.word', $(this).parents('tr')).text()
      )
      .on('dblclick', '.desc', (e) ->
        e.preventDefault()
        if $('.approved', $(this).parents('tr')).length > 0
          scilearn.pronunciation.warningDialog $(@)
        else
          scilearn.pronunciation.editPhonemes $(@)
      )
      .on('keydown', 'input:text', (e) ->
        if e.keyCode is 27
          scilearn.pronunciation.modifyPhonemes $(@)
      )
      .on('blur', 'input:text', ->
        scilearn.pronunciation.modifyPhonemes $(@)
      )
      .on('click', '#search-btn', ->
        $('#pronunciation_form').submit()
        false
      )
      .on('change', '#filter',  ->
        $('#pronunciation_form').submit()
        false
      )
      .on('change', '#per_page',  ->
        $('#pronunciation_form').submit()
        false
      )
      .on('click', '.dataTables_paginate a, #clear_filter, #clear_search', ->
        $.getScript @href
        false
      )
      # form submit
      $('#pronunciation_form').submit ->
        $.get @action, $(@).serialize(),
          $('.word-status').qtip() ,
          "script"
        false

      $('.word-status').qtip()

  modifyPhonemes: ($element) ->
    phonemes = $element.val().trim().toUpperCase()
    if (scilearn.pronunciation.verifyPhonemes phonemes) == false
      $element.addClass('invalid').focus()
    else
      scilearn.pronunciation.editPronunciation $element, phonemes

  getPronunciationId: ($element) ->
    return $element.parents('tr').attr('id').replace('pronunciation_', '')

  verifyPhonemes: (phonemes) ->
    arr = ['AA', 'AE', 'AH', 'AO', 'AW', 'AY', 'B', 'CH', 'D', 'DH', 'EH',
           'ER', 'EY', 'F', 'G', 'HH', 'IH', 'IY', 'JH', 'K', 'L', 'M', 'N','NG',
           'OW', 'OY', 'P', 'R', 'S', 'SH', 'T', 'TH', 'UH', 'UW', 'V', 'W', 'Y', 'Z', 'ZH', '']
    isTrue = true
    phonemes = phonemes.replace(/,/gi, '').split(' ')
    isTrue = false for phoneme in phonemes when $.inArray(phoneme, arr) is -1
    return isTrue

  showReviewDialog: (id, text)->
    alertText = $.convertHtml text
    scilearn.panel.importSelection = art.dialog
      width: 400
      title: 'Approve Pronunciation'
      content: "<p>Do you want to approve pronunciation for the following:</p><p><b>Word/Alternate Text:</b> #{alertText}</p>"
      button: [
        {
          name: 'Yes'
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.pronunciation.approvePronunciation id
        },
        {
          name: 'No'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]
    $(scilearn.panel.importSelection.DOM.wrap).attr("id", "review_dialog")

  warningDialog: ($element)->
    scilearn.panel.importSelection = art.dialog
      width: 350
      title: 'Warning'
      content: "<p>Are you sure you want to change pronunciation that has been approved?</p>"
      button: [
        {
          name: 'Yes'
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.pronunciation.editPhonemes $element
        },
        {
          name: 'No'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]
    $(scilearn.panel.importSelection.DOM.wrap).attr("id", "warning_dialog")

  approvePronunciation: (id) ->
    $.ajax
      url: "/pronunciations/#{id}"
      type: 'PUT'
      success: (data)->
        $('.word-status',"#pronunciation_#{id}").attr('class', "word-status approved").attr('title', "Approved by #{data.user.name}")
      error: (data) ->

  editPronunciation: ($element, phonemes) ->
    id = scilearn.pronunciation.getPronunciationId $element
    $.ajax
      url: "/pronunciations/#{id}"
      data: {"phonemes" : phonemes}
      type: 'PUT'
      success: (data)->
        status_name = data.pronunciation_status.name
        class_name = status_name.replace(' ', '-').toLowerCase()
        $('.word-status',"#pronunciation_#{id}").attr('class', "word-status #{class_name}").attr('title', "#{status_name}")
        scilearn.pronunciation.hideEditPhonemes $element
      error: (data) ->
        $element.addClass('invalid').focus()

  editPhonemes: ($element) ->
    if !$element.hasClass 'edit'
      $input = $('<input/>').prop('type','text').addClass "pure-input"
      $input.val $element.text()
      $element.addClass('pure-form edit').append($input)
      $input.focus()

  hideEditPhonemes: ($element) ->
    $element.parent().removeClass 'edit pure-form'
    $element.parent().text $element.val().toUpperCase()
