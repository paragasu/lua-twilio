-- Lua twilio api 
-- Author: Jeffry L <paragasu@gmail.com>
local requests = require 'requests'
local m = {}
local i = require 'inspect'
local account_sid, auth, from_number

-- setup configuration
function m:new(config_account_sid, auth_token, config_from_number)
  account_sid = config_account_sid
  from_number = config_from_number
  auth = requests.HTTPBasicAuth(account_sid, auth_token)
  return self
end

-- send sms
function m.send(phone_number, messages)
  local api_url  = 'https://api.twilio.com/2010-04-01/Accounts/' .. account_sid .. '/Messages.json'
  local data = {
    To = phone_number,
    From = from_number,
    Body = m.check_message(messages)
  }
  local headers  = { ['Content-Type'] = 'application/x-www-form-urlencoded' }
  local response = requests.post({ url=api_url, auth=auth, data=m.urlencode(data), headers = headers })
  local res = response.json()
  if res.status == "queued" then 
    return true, nil
  else
    return nil, res.message
  end 
end

-- todo: make sure message less than 150chars or 70 chars for unicode
function m.check_message(s)
  if string.len(s) > 150 then error("Message exceeded 150 chars limit") end
  return s
end

-- encode string into escaped hexadecimal representation
-- from socket.url implementation
function m.escape(s)
  return (string.gsub(s, "([^A-Za-z0-9_])", function(c)
    return string.format("%%%02x", string.byte(c))
  end))
end

-- encode url
function m.urlencode(args)
  local params = {}
  for k, v in pairs(args) do table.insert(params, k .. '=' .. m.escape(v)) end
  return table.concat(params, "&")
end

return m
