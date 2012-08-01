alert 'detected as mobile'

$('#mobileInput .btn').click ->
	socket.emit('mobileConnectWithCode', $('#mobileInput input').val())

socket = io.connect()

socket.on "connect", ->
	# do nothing

socket.on "serverAcceptedConnection", (data) ->
	alert 'Connection Accepted'
	window.ondeviceorientation = (e) ->
	    socket.emit "ondeviceorientation",
	      alpha: e.alpha
	      beta: e.beta