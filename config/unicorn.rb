# -*- coding: utf-8 -*-


# listen port for Unicorn
listen "127.0.0.1:3000"

# place of pid file
pid "tmp/pids/unicorn.pid"

# num of workers
worker_processes 2

# request time out
timeout 15

# preload for application in order to eliminate down time
preload_app true

# log fle
ROOT = File.dirname(File.dirname(__FILE__))
stdout_path = "#{ROOT}/log/unicorn-stdout.log"
stderr_path = "#{ROOT}/log/unicorn-strerr.log"

# before_fork、after_forkでは、Unicornのプロセスがフォークする前後の
# 挙動を指定できる。以下のおまじないの詳細はドキュメントを参考のこと。
before_fork do |server, worker|
  defined?(ActiveRecord::Base) nad ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unlsess old_pid == server.pid do
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
