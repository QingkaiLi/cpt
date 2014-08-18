@scilearn.selection =
  init: ->
    jQuery ->
      scilearn.topic.initEvent()

      $('#new_selection_link').click (e) ->
        e.preventDefault()
        $.ajax
          url: $(@).attr 'href'
          success: (data) ->
            scilearn.selection.showSelectionDialog data, 'new'
        false

      $('#topics_index').on 'click', '.selection-edit', (e) ->
        e.preventDefault()
        $.ajax
          url: $(@).attr 'href'
          success: (data) ->
            scilearn.selection.showSelectionDialog data, 'edit'
        false

      $('#topics_index').on 'click', '.icon-copy-move', (e) ->
        e.preventDefault()
        $.ajax
          url: $(@).attr 'href'
          success: (data) ->
            scilearn.selection.showMoveCopyDialog data
          error: (info) ->
            scilearn.notification.error 'There are no other content packs to copy or move a selection to. Create another content pack first.'
        false

      $('#topics_index').on 'click', '.selection-delete', (e) ->
        e.preventDefault()
        scilearn.selection.showDeleteConfirm $(@).parents('.selection')
        false

  saveSelection: (action, formId) ->
    $form = $("##{formId}")

    $.ajax
      data: $form.serialize()
      url : $form.attr 'action'
      type: if action is 'new' then 'POST' else 'PUT'
      dataType: "html"
      success: (data) ->
        scilearn.panel["#{action}Selection"].close()
        scilearn.topic.redrowTree(data)
      error: (info) ->
        scilearn.panel["#{action}Selection"].content info.responseText

  showSelectionDialog: (content, action) ->
    unless action? then action = "new"
    title = if action is 'new' then 'New Selection' else 'Edit Selection Settings'
    formId = $(content).attr "id"

    scilearn.panel["#{action}Selection"] = art.dialog
      id: "#{action}_selection_dialog"
      width: 770
      content: content
      title: title

    $(scilearn.panel["#{action}Selection"].DOM.wrap).attr("id", "#{action}_selection_dialog")

  showDeleteConfirm: ($target) ->
    name = $.convertHtml $('.col-name', $target).text()
    scilearn.panel.deleteSelection = art.dialog(
      title: "Delete Selection"
      content: "<p class=\"confirm-info\">Are you sure you want to delete the selection <i>#{name}</i>?</p>"
      button: [
        {
          name: 'Yes'
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.selection.deleteSelection $target
            true
        },
        {
          name: 'No'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]
    )

  deleteSelection: ($target) ->
    $.ajax
      url: $('.icon-delete', $target).attr('href')
      type: 'DELETE'
      success: (data)->
        scilearn.panel.deleteSelection.close()
        scilearn.selection.removeSelectionEle($target)
      error: (error) ->

  #remove selection element and update total count
  removeSelectionEle: ($selection) ->
    $topic = $selection.siblings('.topic-info').find('.total-count')
    $topic.text(+$topic.text() - 1)
    if +$topic.text() == 0
      $topic.siblings('.icon-delete').removeClass('disabled')
    $selection.remove();
    # update filter result when there is no selection
    if $('#topics_list').find('.topic-info, .selection').length == 1
      $('#filter').addClass('hide');
      $('#topics_list').addClass('empty');

  showMoveCopyDialog: (data, object) ->
    if scilearn.panel.moveCopySelection
      scilearn.panel.moveCopySelection.close()

    scilearn.panel.moveCopySelection = art.dialog
      id: 'move_copy_dialog'
      width: 400
      title: 'Move/Copy Selection'
      content: data
    $(scilearn.panel.moveCopySelection.DOM.wrap).attr("id", "move_copy_dialog")

    $("#move_copy_selection").on 'click', "button[name='move']", (e) ->
      actionUrl = $(this).parents('form').attr('action').replace('move_copy', 'move').replace('copy', 'move')
      $(this).parents('form').attr('action', actionUrl)

    $("#move_copy_selection").on 'click', "button[name='copy']", (e) ->
      actionUrl = $(this).parents('form').attr('action').replace('move_copy', 'copy').replace('move', 'copy')
      $(this).parents('form').attr('action', actionUrl)

  showRenameDialog: ->
    scilearn.panel.renameSelection = art.dialog
      id: 'rename_selection_dialog'
      width: 400
      title: 'Rename Selection'
      content: data
    $(scilearn.panel.renameSelection.DOM.wrap).attr("id", "rename_selection_dialog")

    $('#rename_selection_dialog').on 'click', '.rename-cancle', (e) ->
      scilearn.panel.moveCopySelection.show()
      scilearn.panel.renameSelection.close()