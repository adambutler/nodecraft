// Generated by CoffeeScript 1.3.3
(function(){var e;alert("detected as mobile");$("#mobileInput .btn").click(function(){return e.emit("mobileConnectWithCode",$("#mobileInput input").val())});e=io.connect();e.on("connect",function(){});e.on("serverAcceptedConnection",function(t){alert("Connection Accepted");return window.ondeviceorientation=function(t){return e.emit("ondeviceorientation",{alpha:t.alpha,beta:t.beta})}})}).call(this);