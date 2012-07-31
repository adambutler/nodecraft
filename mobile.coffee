socket = io.connect()

socket.on "connect", ->

  window.ondeviceorientation = (e) ->
    socket.emit "ondeviceorientation",
      alpha: e.alpha
      beta: e.beta