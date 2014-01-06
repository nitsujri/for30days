ready = ->
  $('.flash-close').click( ->
    $('.flash-msgs').fadeOut(1000)
  )

$(document).ready(ready)
$(document).on('page:load', ready)