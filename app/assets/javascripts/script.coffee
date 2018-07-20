window.setTimeout (->
  $('#messages').fadeTo(500, 0).slideUp 300, ->
    $(this).remove()
), 1500
