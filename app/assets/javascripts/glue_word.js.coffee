@scilearn.glue =
  showDialog: (content)->
    scilearn.panel.uploadGlueWord = art.dialog
      id: "upload_glue_words_list"
      title: "Upload Glue Words List"
      width: 450
      height: 100
      content: content
      init: ->
        $('#browse_glue_word_list_btn').click ->
          $('#browse_glue_word_list').click()
          false

        $('#browse_glue_word_list').change ->
          _supportFileApi = window.File and window.FileReader and window.FileList and window.Blob
          _form = $('#glue_word_upload')
          if _supportFileApi
            $('#glue_word_list_name').text(@files[0].name)
            if @files[0].size > 1048576
              _msg = "upload file is larger than 1MB"
            else if @files[0].name.substr(@files[0].name.lastIndexOf('.')) != '.txt'
              _msg = 'file type has to be txt.'
            else if /[^0-9\*\.]/gi.test @files[0].name.split('.txt')[0]
              _msg = 'file name has to be grade level.'

            $('#glue_word_upload .alert-explanation').text _msg

            scilearn.panel.uploadGlueWord.button
                name: 'Upload'
                disabled: _msg?
          else
            $('#glue_word_list_name').text @value
            _form.submit()
      button: [
        {
          focus: true
          name: 'Upload'
          disabled: true
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.panel.uploadGlueWord.button
              name: 'Upload'
              disabled: true

            _formData = new FormData document.forms['glue_word_upload']

            $.ajax
              url: $('#glue_word_upload').prop('action')
              type: "POST"
              data: _formData
              cache: false
              contentType: false
              processData: false
              xhr: ->
                _xhr = $.ajaxSettings.xhr()
              error: ->
                scilearn.notification.error "upload glue words with error."
                scilearn.panel.uploadGlueWord.button
                  name: 'Upload'
                  disabled: false
              success: ->
                scilearn.panel.uploadGlueWord.hide()
                scilearn.notification.info "upload glue words successfully.","Success"

            false
        }
      ]
