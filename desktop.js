// Generated by CoffeeScript 1.6.3
(function() {
  var socket, updateAnimation;

  window.deviceX = 0;

  window.deviceY = 0;

  window.deviceZ = 0;

  window.deviceButtonUp = false;

  window.deviceButtonDown = false;

  window.moveSpeed = 50;

  $('#desktopConnect').show();

  socket = io.connect('http://127.0.0.1/1337');

  socket.on("connect", function() {
    return console.log('codeGenerationHere');
  });

  socket.on("connectionID", function(data) {
    return $('#connectionID').html(data);
  });

  socket.on("mobileDevicePing", function(data) {
    $('#desktopConnect').hide();
    return window.mobileID = data;
  });

  socket.on("receiveOrientation", function(data) {
    window.deviceX = data.beta * (Math.PI / 180);
    return window.deviceZ = data.alpha * (Math.PI / 180);
  });

  socket.on("changeUp", function(data) {
    return window.deviceButtonUp = data;
  });

  socket.on("changeDown", function(data) {
    return window.deviceButtonDown = data;
  });

  updateAnimation = function() {
    window.camera.position.copy(window.camera.matrixWorld.multiplyVector3(new THREE.Vector3(0, 0, window.deviceX * window.moveSpeed)));
    window.camera.rotation.y = window.deviceZ;
    if (window.deviceButtonUp) {
      window.camera.rotation.x += 0.08;
    }
    if (window.deviceButtonDown) {
      window.camera.rotation.x += -0.08;
    }
    window.animate();
    return typeof requestAnimationFrame === "function" ? requestAnimationFrame(updateAnimation) : void 0;
  };

  if (typeof requestAnimationFrame === "function") {
    requestAnimationFrame(updateAnimation);
  }

  $('#loading').hide();

}).call(this);
