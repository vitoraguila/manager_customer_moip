$(document).on 'turbolinks:load', ->
  $('select').material_select();

$(document).on 'turbolinks:before-cache', ->
  $('select').material_select('destroy')
  $('.toast').remove();