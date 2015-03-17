app_name    = "bedevteam"
environment = 'production'
app_path    = "/home/deploy/#{app_name}/#{environment}/current"
pid         = "#{app_path}/tmp/pids/unicorn.pid"

working_directory "#{app_path}"
pid               "#{pid}"
stderr_path       "#{app_path}/log/unicorn.log"
stdout_path       "#{app_path}/log/unicorn.log"

listen "/tmp/unicorn_bedevteam.sock"
worker_processes 4
timeout 180

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection

  old_pid_file = "#{pid}.oldbin"
  if File.exists?(old_pid_file) && server.pid != old_pid_file
    begin
      old_pid = File.read(old_pid_file).to_i
      server.logger.info("sending QUIT to #{old_pid}")
      Process.kill("QUIT", old_pid)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
