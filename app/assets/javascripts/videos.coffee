# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Time change event
progressCheck = (video) ->
    # Get progress from player
    time = Math.round(video.currentTime())
    # If the user scrolled back in time update progress
    if time < window.last_time
        window.progress = time
        update_progress(time)
    window.last_time = time
    
    # Save progress after viewing 10 seconds of video
    if time >= window.progress + 10
        # If we are within the last part of a video, mark completed
        if time > window.end_check
            # Set video as completed
            # "code"
            window.end_check += 60
        window.progress = time
        # Update progress
        update_progress(time)

# Save video progress to db
update_progress = (time) ->
    $.ajax({
        type: "POST",
        # dataType: "script",
        url: window.save_url,
        data: { watch_history:{progress:time}, _method:'patch' }
    })

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
    $('#auto-next').on('click', () ->
        clearInterval(interval)
        document.getElementById('button_next').click()
    )

# VideoJS-Turbolinks support
change = ->
    for player in document.getElementsByClassName 'video-js'
        # Find video player
        video = videojs('main-video-player')
        # Load progress from db
        window.progress = $('#video_p').data('progress')
        window.save_url = $('#video_p').data('url')
        window.last_time = 0
        
        # Actions for after video player is done init
        video.ready( () ->
            video.currentTime(progress)
        )
        
        # Actions for after player loads video meta
        video.on('loadedmetadata', () ->
            duration = video.duration()
            # Set complete time to last 15 seconds or 10% of video, whichever is greater
            if duration < 150 # duration / 10 < 15
                window.end_check = duration - 15
            else
                window.end_check = duration - duration / 10
        )
        
        # Event hooks for video player
        video.on('ended', video_ended)
        video.on('timeupdate', () ->
            progressCheck(this)
        )

before_load = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('main-video-player')
        video.dispose()

$(document).on('turbolinks:load', change)
$(document).on('turbolinks:before-visit', before_load)
