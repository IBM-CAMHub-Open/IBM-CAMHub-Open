#
# Cookbook Name:: ihs
# Provider:: htpasswd_db.rb
#
# Copyright IBM Corp. 2016, 2017
#

include IHSHelper

use_inline_resources

# Create htpasswd password file
def htpasswd_create(htpasswd_path, pwd_db, owner, user, password)
  # Remove file if it exists
  ::File.delete(pwd_db) if ::File.exist?(pwd_db)
  @cmd = "#{htpasswd_path}/htpasswd -cmb #{pwd_db} #{user} \'#{password}\'"
  @cmd_out = run_shell_cmd(@cmd, owner) # rely on shell_out! to fail on errors
  Chef::Log.info "#{pwd_db} updated."
  @cmd_out.stdout
end

# Check htpasswd password file against passed-in user, password
def pwfile_current?(pwfile, user, passwd)
  @openssl_exec = new_resource.openssl_exec
  begin
    @pwfile_c = IO.readlines(pwfile)
  rescue Errno::ENOENT => e
    Chef::Log.debug "File not found: #{pwfile}, error: #{e}"
    return false
  end
  # return false if more than one entry
  Chef::Log.debug "#{pwfile} entries: #{@pwfile_c.length}"
  @pwfile_c.length == 1 || return
  @pwfile_cont = @pwfile_c.first.chomp
  # return false if cannot split by '$'
  @old_user = @pwfile_cont.split('$').first.chop || return
  # return false if authorized user not the one passed in
  Chef::Log.debug "#{pwfile} old_user: #{@old_user}, new user: #{user}"
  @old_user == user || return
  # return false if cannot split by '$'
  @proto = @pwfile_cont.split('$')[1] || return
  Chef::Log.debug "#{pwfile} proto: #{@proto}"
  # return false if @proto not 'apr1'
  @proto == 'apr1' || return
  # return false if cannot split by '$'
  @salt = @pwfile_cont.split('$')[2] || return
  Chef::Log.debug "#{pwfile} salt: #{@salt}"
  begin
    @newcont = IO.popen("#{@openssl_exec} passwd -apr1 -salt #{@salt} #{passwd}").first.chomp
    # return false if openssl not found, will recreate pwfile at each run
    return false if @newcont.nil?
    Chef::Log.debug "#{pwfile} newcont: #{@newcont}"
  rescue Errno::ENOENT => e
    Chef::Log.debug "openssl is not present or unsuitable, error: #{e}"
    return false
  end
  # return false if computed hash does not match recorded one (password changed)
  @computed = user + ':' + @newcont
  @existing = @pwfile_cont
  Chef::Log.debug "#{pwfile} computed content: #{@computed}"
  Chef::Log.debug "#{pwfile} existing content: #{@existing}"
  @computed == @existing
end

action :create do
  dir = new_resource.htpasswd_path
  db = new_resource.htpasswd_db
  owner = new_resource.owner
  group = new_resource.group
  user = new_resource.user
  password = new_resource.password

  if pwfile_current?(db, user, password)
    # pwfile unchanged, don't re-create it
    Chef::Log.info "#{db} is up to date."
  else
    # pwfile changed, update resource
    htpasswd_create(dir, db, owner, user, password)
    new_resource.updated_by_last_action(true) 
  end
  
  # Manage permissions
  file db do
    mode '0640'
    owner owner
    group group
  end
end
