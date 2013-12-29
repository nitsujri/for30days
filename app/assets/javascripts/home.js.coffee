# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  # Resizes Video =================================

  newwidth = $(".video-container").innerWidth()
  $("iframe").css width: newwidth + "px"

  $(window).resize ->
    newwidth = $(".video-container").innerWidth()
    $("iframe").css width: newwidth + "px"

  # Fake Typing ===================================

  #first check if something needs to be deleted
  unless !!window.auto_typing_tasks
    window.auto_typing_tasks = [
      "Run 5 miles",
      "Say thank you",
      "Tell someone I love them",
      "Learn French",
      "Write a blog post",
      "Write a short story",
    ]

  magicType = 
    run: true

  magicType.autoDelete = ->

    return unless magicType.run #break the auto typing

    str = $.trim($("#do-this").html()).slice(0, -1)
    
    $("#do-this").html str

    if str.length > 0
      setTimeout (->
        magicType.autoDelete()
      ), magicType.typingSpeed()
    else
      setTimeout (->
        clip = window.auto_typing_tasks[Math.floor(Math.random() * window.auto_typing_tasks.length)]
        magicType.autoType(clip.split(''))
      ), 1000
      
  magicType.autoType = (aStr) ->
    
    return unless magicType.run #break the auto typing

    char = aStr.shift()
    $("#do-this").html $("#do-this").html() + char

    if aStr.length > 0
      setTimeout (->
        magicType.autoType aStr
      ), magicType.typingSpeed()
    else
      #run the next deletion
      setTimeout (->
        magicType.autoDelete()
      ), 5000

  setTimeout (->
    magicType.autoDelete()
  ), 5000

  magicType.typingSpeed = ->
    #Controls typing speed
    Math.random() * 350

  # Input Value ===================================

  oldVal = $('#do-this').val()
  $(".first-goal-input").on "change keypress paste focus textInput input", ->
    val = @value
    if val isnt oldVal
      oldVal = val
      unless val.trim() == ""
        magicType.run = false
        $('#do-this').html($(this).val())
      else
        $('#do-this').html("")
        magicType.run = true
        magicType.autoDelete()

  # Rolling Suggestions ===========================

  # unless !!window.suggestion_list
  #   window.suggestion_list = [
  #     {profile_pic: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/275912_10700263_599964515_q.jpg", quote: "Facebook"},
  #     {profile_pic: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/275912_10700263_599964515_q.jpg", quote: "Punch someone in the face 2"},
  #     {profile_pic: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/275912_10700263_599964515_q.jpg", quote: "Punch someone in the face 3"},
  #     {profile_pic: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/275912_10700263_599964515_q.jpg", quote: "Punch someone in the face 4"},
  #     {profile_pic: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/275912_10700263_599964515_q.jpg", quote: "Punch someone in the face 5"},
  #   ]

  # roll_suggestions = ->
  #   $('.rolling-suggestor').fadeOut(500, ->
  #     clip = window.suggestion_list[Math.floor(Math.random() * window.suggestion_list.length)]
  #     # alert clip.profile_pic
  #     $('.user-pic').html("<img src='#{clip.profile_pic}' />") unless !!clip.profile_pic
  #     $('.quote').html(clip.quote)
  #     $('.rolling-suggestor').fadeIn(500)
  #   )

  # roll_suggestions()
  # setInterval (->
  #   roll_suggestions()
  # ), 5000

$(document).ready(ready)
$(document).on('page:load', ready)