// Generated by CoffeeScript 1.3.3
(function(){var e,t,n,r,i,s,o,u,a,f,l,c;n=require("express");r=require("http");e=n();t=[];e.configure(function(){return e.use(n["static"](__dirname))});o=r.createServer(e);i=require("socket.io").listen(o);i.set("log level",1);i.sockets.on("connection",function(e){f(e);e.on("ondeviceorientation",c(e));e.on("changeDown",u(e));e.on("changeUp",a(e));e.on("disconnect",l(e));return e.on("mobileConnectWithCode",s(e))});s=function(e){return function(n){if(t[n]!=null){console.log("p2p successfull");e.set("peerID",n);e.emit("serverAcceptedConnection",200);return t[n].emit("mobileDevicePing",n)}return console.log("socket does not exist")}};f=function(e){var n;n=Math.floor(Math.random()*9e4)+1e4;t[n]=e;e.set("connectionID",n);e.emit("connectionID",n);return console.log("Server: New connection - "+e.id+" - "+n)};c=function(e){return function(n){return e.get("peerID",function(e,r){return t[r]?t[r].emit("receiveOrientation",n):console.log("someone broke the connection")})}};u=function(e){return function(t){console.log("down");return e.broadcast.emit("changeDown",t)}};a=function(e){return function(t){console.log("up");return e.broadcast.emit("changeUp",t)}};l=function(e){return function(){console.log("Server: End Connection - "+e.id);return e.get("connectionID",function(e,n){return t[n]=null})}};o.listen(1337)}).call(this);