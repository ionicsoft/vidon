# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Detect when video ends
video_ended = ->
  # console.log("video is over!")
  document.getElementById('button_next').click()

# VideoJS-Turbolinks support
change = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('main-video-player')
        video.on('ended', video_ended)
        # console.log("Change, assigning video")

before_load = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('main-video-player')
        video.dispose()
        # console.log("before_load, disposing of video")

$(document).on('turbolinks:load', change)
$(document).on('turbolinks:before-visit', before_load)
