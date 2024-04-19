local connected = false
local term = require('term')
local fullstringbar = string.rep(' ',160)
local server = loadfile(string.gsub(os.getenv("_"),'launchServer.lua','Server.lua'))('LocalNetwork',"1212",function(ip, message)
  if message == 'connected' then 
    connected = true 
  end
  if type(message) == 'table' and message[1] == 'newMessage' then
    term.setCursor(1,50)
    print(message[2]..fullstringbar)
    term.setCursor(1,50)
    term.write('> ')
  end
end)
server.isServer = false
server.connect(server.methods.scan(1212,1)[1],1212)
term.clear()
server.onDisconnect = function()
  server.stop()
  exit = true
end
while not exit do
  if connected == true then
    term.setCursor(1,50)
    term.write('> ')
    local input = io.read()
    if input == '_exit' then
      server.stop()
      os.exit()
      return false
    end
    server.methods.send(server.connections[1],1212,{'sendingMessage',input})
  end
  require('event').pull(0)
end