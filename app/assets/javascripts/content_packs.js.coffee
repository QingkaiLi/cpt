@scilearn.pack =
  itemPrePage: 10
  # init content pack list when page loaded
  init: ->
    jQuery ->
      scilearn.pack.itemPrePage = 10

      scilearn.pack.initTable()

      $('#new_content_pack_link').click (e) ->
        # e.preventDefault()
        scilearn.pack.getContentPackDialog $(@).attr('href'), 'new'
        false

      # bind edit icon click fn
      $('#content_packs_table').on 'click', '.icon-edit', (e) ->
        e.preventDefault()
        if $(@).isDisabled()
          # show error notification
        else
          scilearn.pack.getContentPackDialog $(@).attr('href'), 'edit'

      # bind delete icon click fn
      $('#content_packs_table').on 'click', '.icon-delete', (e,a,b) ->
        e.preventDefault()
        if $(@).isDisabled()
          scilearn.notification.error $(@).data('message')
        else
          scilearn.pack.showDeleteConfirm $(@).parents('tr')

  # delete one content pack
  delete: ($target) ->
    $.ajax
      url: $('.icon-delete', $target).attr('href')
      type: 'DELETE'
      success: (data)->
        scilearn.panel.deleteContentPack.close()
        cpTable = $('#content_packs_table').dataTable()
        cpTable.fnDeleteRow cpTable.fnGetPosition($target.get(0))
      error: (data) ->
        $.each data.responseJSON, (index, value) ->
          scilearn.notification[index] value

  initTable: ->
    hasData = $('#content_packs_table tbody tr').length > 0
    $('#content_packs_table').dataTable(
      "aoColumns": [null, {"bSortable": false}, {"iDataSort": 6}, null, null, null, null]
      "aLengthMenu": [[10, 30, 50, 100, -1],[10, 30, 50, 100, "Show All"]]
      "iDisplayLength": scilearn.pack.itemPrePage
      "aaSorting": []
      "bFilter": false
      "bPaginate": hasData
      "bInfo": hasData
      "oLanguage":
        "sEmptyTable": "Content Pack List is empty. Create new content packs."
        "sLengthMenu": "Item Per Page _MENU_"
        "sInfo": "Total: _TOTAL_"
        "oPaginate":
          "sNext": ""
          "sPrevious":""
      "sDom": '<"top">rt<"bottom"ipl><"clear">'
      "sPaginationType": "full_numbers"
    ).on("draw", (e, obj) ->
      scilearn.pack.itemPrePage = obj._iDisplayLength
    )

    $('.icon-edit, .icon-delete').qtip()
    $('.content-pack-name').each ->
      $(@).qtip({
        content: {
          text: $(@).html()
        }
      })
    
  redrowTable: (data) ->
    $('#content_packs_table').dataTable().fnDestroy()
    $('#content_packs_table').html $('#content_packs_table', data).html()
    scilearn.pack.initTable()

  getContentPackDialog: (url, type) ->
    if sessionStorage.getItem("new_content_pack") and type is "new"
      scilearn.pack.showContentPackDialog()
    else
      $.ajax
        url: url
        success: (data) ->
          sessionStorage.setItem("new_content_pack", data) if type is "new"
          scilearn.pack.showContentPackDialog data, type
        error: ->

  showContentPackDialog: (content, action) ->
    unless content? then content = sessionStorage.getItem "new_content_pack"
    unless action? then action = "new"
    title = if action is "new" then "New Content Pack" else "Edit Content Pack Settings"
    formId = $(content).attr "id"

    scilearn.panel["#{action}ContentPack"] = art.dialog
      id: "#{action}_content_packs_dialog"
      width: 767
      height: 300
      content: content
      title: title

    $(scilearn.panel["#{action}ContentPack"].DOM.wrap).attr("id", "#{action}_content_packs_dialog")

  showDeleteConfirm: ($target) ->
    scilearn.panel.deleteContentPack = art.dialog
      id: "content_packs_delete_confirm"
      title: "Delete Content Pack"
      content: "<p class=\"confirm-info\">Are you sure you want to delete the <i>" + $.convertHtml($('.content-pack-name', $target).text()) + "</i> content pack?</p>"
      button: [
        {
          focus: true
          name: 'Yes'
          className: "pure-button pure-button-small pure-button-success"
          callback: ->
            scilearn.pack.delete $target
            false
        },
        {
          name: 'No'
          className: "pure-button pure-button-small pure-button-cancel"
        }
      ]

    $(scilearn.panel.deleteContentPack.DOM.wrap).attr("id", "content_packs_delete_confirm")