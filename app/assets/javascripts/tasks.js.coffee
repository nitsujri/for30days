# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('#task-start-date').datepicker({
    format: "yyyy-mm-dd"
  });

  oldVal = $('#do-this').val()
  origVal = "Tackle This" #I can't get it to copy properly
  $("#new-goal-name").on "change keypress paste focus textInput input", ->
    val = @value
    if val isnt oldVal
      oldVal = val
      unless val.trim() == ""
        $('#do-this').html($(this).val())
      else
        $('#do-this').html(origVal)

$(document).ready(ready)
$(document).on('page:load', ready)