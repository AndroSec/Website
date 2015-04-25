
$ ->
  $('#query-form').submit( (e) ->
    e.preventDefault()
    sql = $('#query').val()
    sendQuery(sql)
  )

  $('body').on('click', '.info-link', (e) ->
    e.preventDefault()
    
    $('.info-link').removeClass('active')
    $('.sections').hide()

    $(e.target).parent().addClass('active')

    section = "##{$(e.target).parent().attr('id')}-content"
    $(section).show()
  )

  $('.example').click( (e) -> 
    e.preventDefault()
    queryId = $(e.target).attr('id')
    sql = "SELECT *  FROM #{queryId}"
    sendQuery(sql)
  )

sendQuery = (sql) ->
  $.ajax
    url: "/queries"
    type: "POST"
    data: 
      query: sql
    success: (data, textStatus, jqXHR) ->
      $("#query-results-container").html(data)
    error: (request, status, error) ->
      $("#query-results-container").html("#{error}, please try again.")