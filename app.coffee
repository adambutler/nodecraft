express = require("express")
http = require("http")
app = express()

app.configure ->
  app.use express.static(__dirname)

server = http.createServer(app)
io = require("socket.io").listen(server)

# Set log level to 1 (warn)
io.set "log level", 1

# Listen for connection
io.sockets.on "connection", (socket) ->
  # Handle connection
  socketConnect socket
  # Add listeners
  socket.on "ondeviceorientation", socketOrientationUpdate(socket)
  socket.on "changeDown", socketChangeDown(socket)
  socket.on "changeUp", socketChangeUp(socket)
  socket.on "disconnect", socketDisconect(socket)


socketConnect = (socket) ->
  console.log "Server: New connection - " + socket.id

socketOrientationUpdate = (socket) ->
  console.log('Got Orientation')
  (data) ->
    # console.log "x = #{data.x} y = #{data.y} z = #{data.z}"
    socket.broadcast.emit "receiveOrientation", data

socketChangeDown = (socket) ->
  (data) ->
    console.log 'down'
    socket.broadcast.emit "changeDown", data

socketChangeUp = (socket) ->
  (data) ->
    console.log 'up'
    socket.broadcast.emit "changeUp", data

socketDisconect = (socket) ->
  ->
    console.log "Server: End Connection - " + socket.id


server.listen 1337
