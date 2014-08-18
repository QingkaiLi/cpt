@scilearn.topic =
  init: ->
    jQuery ->
      scilearn.topic.initEvent()

      $("header .icon-edit").click ->
        scilearn.pack.getContentPackDialog $(@).attr('href'), 'edit'
        false

      $('#new_topic_link').click (e) ->
        e.preventDefault()
        $.ajax
          url: $(@).attr 'href'
          success: (data) ->
            scilearn.topic.showTopicDialog data, 'new'
        false

      $('#topics_index').on "click", ".icon-drop-down", ->
        $(@).toggleClass("icon-arrow-right").toggleClass("icon-arrow-down")
        .parents('.undefault-topic').find('.selection').toggle()

      $('#topics_index').on 'click', '.topic-edit', (e) ->
        e.preventDefault()
        $.ajax
          url: $(@).attr 'href'
          success: (data) ->
            scilearn.topic.showTopicDialog data, 'edit'
        false

      $('#topics_index').on 'click', '.topic-delete', (e) ->
        e.preventDefault()
        if $(@).isDisabled()
          scilearn.notification.error $(@).data('message')
        else
          scilearn.topic.showDeleteConfirm $(@).parents('.topic-info')
        false

      $('#topics_index').on 'change', '#filter_by', ->
        switch $(@).val()
          when '0'
            scilearn.topic.clearFilter()
          when '1'
            scilearn.topic.toggleSortFn false

            $('#filter_status, #filter_clear').removeClass 'hide'
            $('#filter_status')[0].selectedIndex = 0
            $('#filter_errors').addClass 'hide'
            scilearn.topic.filter $('#filter_status').val()
          else
            scilearn.topic.toggleSortFn false

            $('#filter_errors, #filter_clear').removeClass 'hide'
            $('#filter_status').addClass 'hide'
            $('#filter_errors')[0].selectedIndex = 0
        false

      $('#topics_index').on 'change', '#filter_status, #filter_errors', ->
        scilearn.topic.filter $('#filter_status').val()
        false

      $('#topics_index').on 'click', '#filter_clear', ->
        $("#filter_by").val(0)
        scilearn.topic.clearFilter()
        false
  
  # disable sort fn
  toggleSortFn: (sw) ->
    sort = $('#topics_list, #topics_list ul')
    sw = if sw? then sw else sort.sortable 'option','disabled'
    sort.sortable(if sw then 'enable' else 'disable')

  filter: (status_id) ->
    $('.topic', '#topics_list').each ->
      $(@).show()
      $('.selection', @).each ->
        $(@).toggle($(@).attr('status') is status_id)
      if $('.selection:visible', @).length is 0
        $(@).hide()

    $('#topics_list').toggleClass 'empty', $('.selection:visible').length is 0

    $('#topic_header').parents('.topic').show()

  clearFilter: ->
    $('.selection, .topic').show()
    $('#filter_by').prop 'value', 0
    $('#filter_status, #filter_errors, #filter_clear').addClass 'hide'
    $('#topics_list').removeClass 'empty'
    scilearn.topic.toggleSortFn true

  toggleFilter: ->
    $('#filter').toggle($('.topic').length is 1 and $('.selection').length is 0)

  saveSelectionsOrder: (event, ui) ->
    $target = ui.item
    $targetParent = ui.item.parent()
    $toCountSelector = $targetParent.find('.total-count')
    $fromCountSelector = $(event.target).find('.total-count')

    $.ajax
      data: {'to_priority' : $('.selection', $targetParent).size() - $('.selection', $targetParent).index($target) - 1, 'to_topic_id' : $targetParent.find('.topic-info')[0].id.replace('topic_', '')}
      url : 'selections/ordering/' + $target[0].id.replace('selection_', '')
      type: 'POST'
      success: (data) ->
        # update selection total number of topic
        $toCountSelector.text(+$toCountSelector.text()+1)
        $fromCountSelector.text(+$fromCountSelector.text()-1)

        # update delete icon disabled status
        if +$toCountSelector.text() == 1
          $toCountSelector.siblings('.icon-delete').addClass('disabled')
        if +$fromCountSelector.text() == 0
          $fromCountSelector.siblings('.icon-delete').removeClass('disabled')
      error: (data) ->
        $.each data.responseJSON, (index, value) ->
          scilearn.notification[index] value

  saveTopicsOrder: (event, ui) ->
    $.ajax
      data: {'to_priority' : $('#topics_list .undefault-topic').size() - ui.item.index()}
      url : 'topics/ordering/' + ui.item.find('.topic-info')[0].id.replace('topic_', '')
      type: 'POST'
      success: (data) ->
      error: (info) ->
        $.each data.responseJSON, (index, value) ->
          scilearn.notification[index] value

  deleteTopic: ($target) ->
    $.ajax
      url: $('a.icon-delete', $target).attr('href')
      type: 'DELETE'
      success: (data) ->
        scilearn.panel.deleteTopic.close()
        $target.remove()
      error: (data) ->
        $.each data.responseJSON, (index, value) ->
          scilearn.notification[index] value

  # redrow tree and bind event
  redrowTree: (data) ->
    $('#topics_list').replaceWith $('#topics_list', data)
    $('#filter').replaceWith $('#filter', data)
    scilearn.topic.initEvent()

  initEvent: ->
    # topics sort
    $('#topics_list').sortable
      delay: 200
      containment: '#topics_list'
      items: '.undefault-topic'
      axis: 'y'
      placeholder :
        element: (currentItem) ->
          $("<li class='topic-placeholder topic'>#{currentItem[0].innerHTML}</li>")[0]
        update: (container, p) ->
      start: (event, ui) ->
        if ui.helper.find('.icon-arrow-down').length > 0
          ui.helper.find('.icon-drop-down').click()
      stop: (event, ui) ->
        scilearn.topic.saveTopicsOrder(event, ui)

    # selection sort
    $('#topics_list ul').sortable
      delay: 200
      containment: '#topics_list'
      connectWith: '#topics_list ul'
      items: '.selection'
      axis: 'y'
      placeholder :
        element: (currentItem) ->
          $("<li class='selection-placeholder selection'>#{currentItem[0].innerHTML}</li>")[0]
        update: (container, p) ->
      over: (event, ui) ->
        $dropdown = $(event.target).find('.icon-drop-down')
        if $dropdown.hasClass('icon-arrow-right')
          $dropdown.click()
          ui.placeholder.show()
      stop: (event, ui) ->
        scilearn.topic.saveSelectionsOrder(event, ui)

    $('.icon-edit, .icon-delete, .icon-copy-move',"#topics_list").qtip()
    $('.col-name',"#topics_list").each ->
      $(@).qtip({
        content: {
          text: $(@).html()
        }
      })

  showDeleteConfirm: ($target) ->
    name = $.convertHtml $('.col-name', $target).text()
    scilearn.panel.deleteTopic = art.dialog(
      title: "Delete Topic"
      content: "<p class=\"confirm-info\">Are you sure you want to delete the topic <i> #{name} </i>?</p>"
      button: [
        {
          focus: true
          name: 'Yes'
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.topic.deleteTopic $target
            true
        },
        {
          name: 'No'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]
    )

  showTopicDialog: (content, action) ->
    unless action? then action = "new"
    title = if action is 'new' then 'New Topic' else 'Edit Topic Settings'
    formId = $(content).attr "id"

    scilearn.panel["#{action}Topic"] = art.dialog
      id: "#{action}_topic_dialog"
      width: 400
      content: content
      title: title

    $(scilearn.panel["#{action}Topic"].DOM.wrap).attr("id", "#{action}_topic_dialog")

