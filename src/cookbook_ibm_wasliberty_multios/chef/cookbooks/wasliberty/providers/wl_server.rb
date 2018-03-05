########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: wasliberty
###############################################################################

use_inline_resources

def srv_running
  return unless RUBY_PLATFORM =~ /linux/
  cmdobj = Mixlib::ShellOut.new("ps -ef | grep  #{@new_resource.name} | grep java")
  cmdobj.run_command.stdout.split("\n").reject { |e| e.include? "sh -c" }.size >= 1 # true or false
end

def kill_srv
  return unless RUBY_PLATFORM =~ /linux/
  cmdobj = Mixlib::ShellOut.new("ps -ef | grep  #{@new_resource.name} | grep java")
  lines = cmdobj.run_command.stdout.split("\n").reject { |e| e.include? "sh -c" }
  pids = lines.map { |ln| ln.split[1] }.join(" ")
  Mixlib::ShellOut.new("kill -9 #{pids}").run_command
end

def stop_srv
  return unless srv_running
  return unless RUBY_PLATFORM =~ /linux/
  cmdobj = Mixlib::ShellOut.new("su - #{@new_resource.user} -c '#{@new_resource.install_dir}/bin/server stop #{@new_resource.name}'")
  cmdoutput = cmdobj.run_command.stdout
  Chef::Log.info cmdoutput
  puts cmdoutput

  elapsed = 0
  loop do
    break if elapsed >= @new_resource.timeout.to_i || !srv_running
    sleep 5
    elapsed += 5
  end

  return unless elapsed >= @new_resource.timeout.to_i || srv_running
  kill_srv
  return unless srv_running
  raise "Timeout exceeded when trying to stop server #{@new_resource.name}"
end

def start_srv
  unless srv_running
    if RUBY_PLATFORM =~ /linux/
      cmdobj = Mixlib::ShellOut.new("su - #{@new_resource.user} -c '#{@new_resource.install_dir}/bin/server start #{@new_resource.name}'")
      cmdoutput = cmdobj.run_command.stdout
      Chef::Log.info cmdoutput
      puts cmdoutput
    end
  end

  elapsed = 0
  loop do
    break if elapsed >= @new_resource.timeout.to_i || srv_running
    sleep 5
    elapsed += 5
  end

  return unless elapsed >= @new_resource.timeout.to_i || !srv_running
  raise "Timeout exceeded when trying to start server #{@new_resource.name}"
end

# ----------------------------------------------------#
#                      Actions                        #
# ----------------------------------------------------#

action :stop do
  stop_srv
end

action :start do
  if srv_running && !@new_resource.force_restart
    Chef::Log.info("Server #{new_resource.name} is already running")
    new_resource.updated_by_last_action(false)
  else # server not running, OR force_restart = true, OR...both !
    if srv_running # and force_restart = true ...
      stop_srv
    end
    start_srv
    new_resource.updated_by_last_action(true)
  end
end
