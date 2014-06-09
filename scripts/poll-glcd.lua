require "library/nsq"
require "os"
require "conf"
require "json"

local clientid, recv = ...

local nsq = require "library/nsqc"

local c = nsq.new(settings.nsq_host, settings.nsq_port)

c:subscribe(settings.nsq_gamestate_topic, clientid)

local handler = function(job)
  -- print(string.format(
  --     "got job %s with %d attempts and body %s",
  --     job.id, job.attempts, job.body
  --     ))
  recv:push(job.body)
  return true
end

while true do
  c:consume_one(handler)
end
