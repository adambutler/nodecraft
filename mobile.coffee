
$(document).ready ->
    $('#mobileInput .btn').click ->
        socket.emit('mobileConnectWithCode', $('#mobileInput input').val())

    socket = io.connect()

    socket.on "connect", ->
        # do nothing

    socket.on "error", (error) ->
        alert error

    socket.on "serverAcceptedConnection", (data) ->
        window.addEventListener('deviceorientation',  emitOrientation, false)

    emitOrientation = (e) ->
        socket.emit "ondeviceorientation",
          alpha: e.alpha
          beta: e.beta

    socket.on "lostConnection", (data) ->
        alert('sorry the connection was lost :-(')
        window.removeEventListener('deviceorientation',  emitOrientation, false)