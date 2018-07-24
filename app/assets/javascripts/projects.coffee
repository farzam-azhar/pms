$(window).on 'shown.bs.modal', ->
  date = new Date
  date.setDate date.getDate() + 1
  $('.datepicker').datepicker startDate: date, format: "yyyy-mm-dd"
