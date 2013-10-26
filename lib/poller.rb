# A simple, threaded poller.
# More useful, of course, if there are multiple actions to wait on.

require 'thread'

queue = Queue.new

poller = Thread.new do
  begin
    sleep(3)
    status = nsc.scan_status(scan.id)
  end while status == 'running'
  queue << status
end
    
wait = Thread.new do
  done = queue.pop
end
wait.join
