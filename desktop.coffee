window.deviceX = 0
window.deviceY = 0
window.deviceZ = 0
window.deviceButtonUp = false
window.deviceButtonDown = false
window.moveSpeed = 50

$('#desktopConnect').show()

socket = io.connect('http://nodecraft.lab.io:1337')

socket.on "connect", ->
  console.log 'codeGenerationHere'

socket.on "connectionID", (data) ->
	$('#connectionID').html(data)

socket.on "mobileDevicePing", (data) ->
	$('#desktopConnect').hide()
	window.mobileID = data

socket.on "receiveOrientation", (data) ->
  window.deviceX = data.beta * (Math.PI / 180)
  window.deviceZ = data.alpha * (Math.PI / 180)

socket.on "changeUp", (data) ->
  window.deviceButtonUp = data

socket.on "changeDown", (data) ->
  window.deviceButtonDown = data

updateAnimation = ->

	window.camera.position.copy(window.camera.matrixWorld.multiplyVector3(new THREE.Vector3(0,0, window.deviceX * window.moveSpeed)))

	window.camera.rotation.y = window.deviceZ;

	if window.deviceButtonUp
		window.camera.rotation.x += 0.08;

	if window.deviceButtonDown
		window.camera.rotation.x += -0.08;
	

	window.animate()
	requestAnimationFrame?(updateAnimation)

requestAnimationFrame?(updateAnimation)

$('#loading').hide()