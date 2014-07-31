# -*- coding: utf-8 -*-


# listen port for Unicorn
listen "127.0.0.1:3000"

# place of pid file
pid "tmp/pids/unicorn.pid"

# num of workers
worker_processes 2

# request time out
timeout 15
print "<<< DEBUG >>> OK after setting timeout 15"
# preload for application in order to eliminate down time
preload_app true
print "<<< DEBUG >>> OK after setting preload_app true"
# log fle
stdout_path = "log/unicorn-stdout.log"
stderr_path = "log/unicorn-strerr.log"
print "<<< DEBUG >>> OK after setting stdout_path AND stderr_path"
# before_fork、after_forkでは、Unicornのプロセスがフォークする前後の
# 挙動を指定できる。以下のおまじないの詳細はドキュメントを参考のこと。
before_fork do |server, worker|
print "<<< DEBUG >>> OK next defined? IN before_fork"
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
print "<<< DEBUG >>> OK next old_pid = IN before_fork"
  old_pid = "#{ server.config[:pid] }.oldbin"
print "<<< DEBUG >>> OK next unless old_pid IN before_fork"
  unlsess old_pid == server.pid do
    begin
print "<<< DEBUG >>> OK next 1 IN before_fork"
      Process.kill :QUIT, File.read(old_pid).to_i
print "<<< DEBUG >>> OK next 2 IN before_fork"
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
print "<<< DEBUG >>> OK next 3 IN before_fork"
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
print "<<< DEBUG >>> OK next 4 IN before_fork"
end
