siteList = ->
  siteTable = $('#top-sites').dataTable(
    ajax:
      url: '/sites.json'
      dataSrc: ''
    serverSide: true
    processing: true
    rowReorder:
      dataSrc: 'rank'
    columns: [
      {data: 'rank'},
      {data: 'name'},
      {
        data: 'url'
        render: (data, type, full, meta) ->
          return """<a href="#{data}" target="_blank">#{data}</a>"""
      },
      {data: 'description'}
    ],
    responsive:true,
  )
  siteTable.fnSetFilteringDelay();

  siteTable.on('row-reorder.dt', (e, details, edit) ->
    data = {}
    for change in details
      siteId = siteTable.api().row(change.node).data().id
      data[siteId] = change.newData
    $.ajax
      url: '/sites/update_rank'
      type: 'POST'
      dataType: 'json'
      data: 
        ranks: data
  );

  $('#top-sites tbody').on 'click', 'tr > td:not(:first-child)', ->
    data = siteTable.api().row($(@).parents('tr')).data()
    $.ajax
      url: "/sites/#{data.id}/edit"
      dataType: 'script'

  $(document).on "ajax:success", "#site-modal form", (e) ->
    siteTable.api().draw(false)

$(document).ready(siteList)