$ ->
  $('#query-form').submit( (e) ->
    e.preventDefault()
    sql = $('#query').val()
    $.ajax
      url: "/queries"
      type: "POST"
      data: 
        query: sql
      success: (data, textStatus, jqXHR) ->
        $("#query-results-container").html(data)
      error: (request, status, error) ->
        $("#query-results-container").html("#{error}, please try again.")
  )