# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#new_fee_transaction").on("ajax:success", (e, data, status, xhr) ->
    location.reload()
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#fee-input").append "<p>ERROR</p>"

