$(window).on 'shown.bs.modal', ->
  date = new Date
  date.setDate date.getDate() + 1
  $('#datetimepicker1').datetimepicker
    format: 'YYYY-MM-DD'
    minDate: date
    useCurrent: false
