local server 
server = loadfile(string.gsub(os.getenv("_"),'launchServer.lua','Server.lua'))('LocalNetwork',"1212",function(ip, message)
  if type(message) == 'table' and message[1] == 'sendingMessage' then
    if #server.connections > 1 and server.connections[1] == ip then
      server.methods.send(server.connections[2],1212,{'newMessage',message[2]})
    elseif #server.connections > 1 and server.connections[2] == ip then
      server.methods.send(server.connections[1],1212,{'newMessage',message[2]})
    end
  end
end)
while true do
  name, _, _, key = require('event').pull(0)
  if name == 'key_down' and key == 57 then
    server.stop()
    return
  end
end