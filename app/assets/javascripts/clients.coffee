# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
  $('.swal').on 'click', (e) ->
    _this2 = this
    e.preventDefault()
    swal(
      title: 'Are you sure?'
      text: 'You are going to Disable this Client.'
      icon: 'warning'
      buttons: true
      dangerMode: true).then (willDelete) ->
      if willDelete
        $.ajax
          url: $(_this2).attr('href')
          method: 'GET'
          dataType: 'script'
          success: ((_this) ->
            ->
              swal 'Disabled!', 'Your Client has been Disabled.', 'success'
          )(_this2)
      else
        swal 'Your Client is still Enabled!'
