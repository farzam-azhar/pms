$(document).ready ->
  $('#time-logs-table').DataTable()

$(window).on 'shown.bs.modal', ->
  $('.datetimepicker').datetimepicker
    format: 'LT'

$(window).on 'shown.bs.modal', ->
  $('.datetimepicker').datetimepicker
    format: 'LT'
