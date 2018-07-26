$(window).on 'shown.bs.modal', ->
  $('.timepicker').timepicker();

$(document).ready ->
  $('#time-logs-table').DataTable()

