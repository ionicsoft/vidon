# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Detect when video ends
video_ended = ->
    
    $('#autoplayModal').modal('show')
    counter = 10;
    interval = setInterval () ->
        counter--
        # Display 'counter' wherever you want to display it.
        $('#autoplayModalTimer').text(counter)
        if counter == 0
            # Display a login box
            clearInterval(interval)
            $('#autoplayModal').modal('hide')
            document.getElementById('button_next').click()
    , 1000
    $('#autoplayModal').on('hidden.bs.modal', () ->
        clearInterval(interval)
    )

# VideoJS-Turbolinks support
change = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('main-video-player')
        video.on('ended', video_ended)

before_load = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('main-video-player')
        video.dispose()

$(document).on('turbolinks:load', change)
$(document).on('turbolinks:before-visit', before_load)
