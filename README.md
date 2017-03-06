# lua-twilio
Lua twilio sms api.


# Example Usage

### **new** _(account\_sid, auth\_token)_
  create new twilio object
  param
  - account\_sid from twilio dashboard setting
  - auth\_token from twilio dashboard setting
  

### **send** _(phone\_number, message)_
  send sms message
  param
  - phone\_number valid phone number in international format eg: +60123456789
  - message message maximum 150 chars or 70 chars for unicode


```lua

local twilio = require 'twilio'
local sms = twilio.new(config.account_sid, config.auth_token)
local ok, err  = sms.send('+60123456789', 'Hello World')
if not ok then error(err) end

```

# Reference

[Twilio API](https://www.twilio.com/docs/api/rest/sending-messages)
