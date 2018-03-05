# encoding: UTF-8
########################################################
# Copyright IBM Corp. 2012, 2017
########################################################
#
# Cookbook Name:: ibm_cloud_utils
###############################################################################
require 'chef/resource/powershell_script'
# include Chef::Provider::PowershellScript

use_inline_resources

def whyrun_supported?
  true
end

action :unpack do
  parse_extension
  basename = @basename
  local_archive = ::File.join(new_resource.target_dir, basename)

  Chef::Log.debug("DEBUG: Unpacking #{local_archive}")

  Chef::Log.debug("DEBUG: Creating target directory #{new_resource.target_dir}")
  directory new_resource.target_dir do
    recursive true
    unless RUBY_PLATFORM =~ /win|mingw/
      group new_resource.group
      owner new_resource.owner
      mode new_resource.mode
    end
  end

  # TODO: check free space for unpack
  Chef::Log.debug("DEBUG: Transfer remote file #{new_resource.source}")

  if new_resource.secure_repo == "true"
    require 'chef-vault'
    sw_repo_password = chef_vault_item(new_resource.vault_name, new_resource.vault_item)['ibm']['sw_repo_password']
    raise "No password found for repo user in chef vault \'#{new_resource.vault_name}\'" if sw_repo_password.empty?
  end

  if new_resource.repo_self_signed_cert == "true"
    require 'net/http'
    require 'socket'
    require 'openssl'
    if RUBY_PLATFORM =~ /win|mingw/
      cacert = "C:\\opscode\\chef\\embedded\\ssl\\certs\\cacert.pem"
      hosts = "C:\\Windows\\System32\\drivers\\etc\\hosts"
    else
      cacert = "/opt/chef/embedded/ssl/certs/cacert.pem"
      hosts = "/etc/hosts"
    end
    uri = URI.parse(new_resource.source)
    tcp_client = TCPSocket.new(uri.host, uri.port)
    ssl_client = OpenSSL::SSL::SSLSocket.new(tcp_client)
    ssl_client.connect
    cert = OpenSSL::X509::Certificate.new(ssl_client.peer_cert)
    cacert = open(cacert, 'a+')
    if cacert.include? cert.to_pem
      Chef::Log.info "Self signed cert found in #{cacert}"
    else
      cacert.write(cert)
    end
    cacert.close
    cert_name = cert.subject.to_a.find { |name, _, _| name == 'CN' }[1]
    etc_hosts = open(hosts, 'a+')
    if etc_hosts.include? "#{uri.host} #{cert_name}\n"
      Chef::Log.info "line #{uri.host} #{cert_name} found in #{hosts}"
    else
      etc_hosts.write("#{uri.host} #{cert_name}\n")
    end
    etc_hosts.close
    repo_source = new_resource.source.gsub(uri.host.to_s, cert_name.to_s)
  else
    repo_source = new_resource.source
  end

  remote_file local_archive do
    source repo_source
    checksum new_resource.checksum
    backup false
    action :create
    unless RUBY_PLATFORM =~ /win|mingw/
      group new_resource.group
      owner new_resource.owner
      mode new_resource.mode
    end
    headers("Authorization"=>"Basic #{Base64.encode64("#{new_resource.sw_repo_user}:#{sw_repo_password}").gsub('\n', '')}") if new_resource.secure_repo == "true" # ~password_checker

    if RUBY_PLATFORM =~ /win|mingw/
      notifies :create, "template[#{new_resource.target_dir}\\tmpscr.vbs]", :immediately
      notifies :run, "powershell_script[unzip-#{basename}]", :immediately
      notifies :delete, "file[#{new_resource.target_dir}\\tmpscr.vbs]", :immediately
    else
      notifies :run, "execute[extract-#{basename}]", :immediately
    end
  end

  command = unpack_command(local_archive)

  if RUBY_PLATFORM =~ /win|mingw/
    Chef::Log.debug('DEBUG: Unzip on Wingoze using powershell_script')

    # instantiate the unzip vbs script from template
    template "#{new_resource.target_dir}\\tmpscr.vbs" do
      source 'unpack.vbs.erb'
      variables(
        :zipfile => local_archive.tr('/', '\\'),
        :target_dir => new_resource.target_dir
      )
      cookbook 'ibm_cloud_utils'
      only_if { local_archive.end_with? ".zip" }
      action :nothing
    end

    powershell_script "unzip-#{basename}" do
      code <<-EOH
      $archPath = "#{local_archive.tr('/', '\\')}"

      if ($archPath.ToLower().EndsWith('.tar') -or $archPath.ToLower().EndsWith('.tar.gz') -or $archPath.ToLower().EndsWith('.tgz')){
        cmd /c 'c:\\opscode\\chef\\bin\\tar.exe' -xf $archPath -C "#{new_resource.target_dir}"
      }elseif($archPath.ToLower().EndsWith('.zip')){
        cscript #{new_resource.target_dir}\\tmpscr.vbs
      }
      EOH

      # Force extracting the archive when force_extract = true
      if new_resource.force_extract
        action :run
      else
        action :nothing
      end
      notifies :delete, "file[#{local_archive}-#{new_resource.name}]", :immediately
    end

    # cleanup the vbs unzip script
    file "#{new_resource.target_dir}\\tmpscr.vbs" do
      action :nothing
    end

  else
    Chef::Log.debug("DEBUG: Unpack on Unix using command #{command}")
    execute "extract-#{basename}" do
      command command
      cwd new_resource.target_dir
      group new_resource.group
      user new_resource.owner
      # Force extracting the archive when force_extract = true
      if new_resource.force_extract
        action :run
      else
        action :nothing
      end
      notifies :delete, "file[#{local_archive}-#{new_resource.name}]", :immediately
    end
  end

  file "#{local_archive}-#{new_resource.name}" do
    path local_archive
    action :nothing
    backup false
    only_if { new_resource.remove_local }
  end

  new_resource.updated_by_last_action(true)
end

action :download do
  parse_extension
  basename = @basename
  local_archive = ::File.join(new_resource.target_dir, basename)

  Chef::Log.debug("DEBUG: Downloading #{local_archive}")

  Chef::Log.debug("DEBUG: Creating target directory #{new_resource.target_dir}")
  directory new_resource.target_dir do
    recursive true
    unless RUBY_PLATFORM =~ /win|mingw/
      group new_resource.group
      owner new_resource.owner
      mode new_resource.mode
    end
  end

  # TODO: check free space for unpack
  Chef::Log.debug("DEBUG: Transfer remote file #{new_resource.source}")

  if new_resource.secure_repo == "true"
    require 'chef-vault'
    sw_repo_password = chef_vault_item(new_resource.vault_name, new_resource.vault_item)['ibm']['sw_repo_password']
    raise "No password found for repo user in chef vault \'#{new_resource.vault_name}\'" if sw_repo_password.empty?
  end

  if new_resource.repo_self_signed_cert == "true"
    require 'net/http'
    require 'socket'
    require 'openssl'
    if RUBY_PLATFORM =~ /win|mingw/
      cacert = "C:\\opscode\\chef\\embedded\\ssl\\certs\\cacert.pem"
      hosts = "C:\\Windows\\System32\\drivers\\etc\\hosts"
    else
      cacert = "/opt/chef/embedded/ssl/certs/cacert.pem"
      hosts = "/etc/hosts"
    end
    uri = URI.parse(new_resource.source)
    tcp_client = TCPSocket.new(uri.host, uri.port)
    ssl_client = OpenSSL::SSL::SSLSocket.new(tcp_client)
    ssl_client.connect
    cert = OpenSSL::X509::Certificate.new(ssl_client.peer_cert)
    cacert = open(cacert, 'a+')
    if cacert.include? cert.to_pem
      Chef::Log.info "Self signed cert found in #{cacert}"
    else
      cacert.write(cert)
    end
    cacert.close
    cert_name = cert.subject.to_a.find { |name, _, _| name == 'CN' }[1]
    etc_hosts = open(hosts, 'a+')
    if etc_hosts.include? "#{uri.host} #{cert_name}\n"
      Chef::Log.info "line #{uri.host} #{cert_name} found in #{hosts}"
    else
      etc_hosts.write("#{uri.host} #{cert_name}\n")
    end
    etc_hosts.close
    repo_source = new_resource.source.gsub(uri.host.to_s, cert_name.to_s)
  else
    repo_source = new_resource.source
  end

  remote_file local_archive do
    source repo_source
    checksum new_resource.checksum
    backup false
    action :create
    unless RUBY_PLATFORM =~ /win|mingw/
      group new_resource.group
      owner new_resource.owner
      mode new_resource.mode
    end
    headers("Authorization"=>"Basic #{Base64.encode64("#{new_resource.sw_repo_user}:#{sw_repo_password}").gsub('\n', '')}") if new_resource.secure_repo == "true" # ~password_checker
  end

  new_resource.updated_by_last_action(true)
end

private

# parse extension
def parse_extension
  url = new_resource.source.clone
  if url =~ /^https?:\/\/.*?(\.gz|\.Z|\.xz|\.bz2|\.bin|\.zip|\.jar|\.war|\.tgz|\.tbz|\.txz|\.tar|\.iso|\.exe)(\/.*\/)/
    url.gsub!(Regexp.last_match[2], '')
  end

  @basename = ::File.basename(url.gsub(/\?.*\z/, '')).gsub(/-bin\b/, '')
  Chef::Log.debug("DEBUG: basename is #{@basename}") if @basename =~ %r{^(.+?)\.(tar\.gz|tar\.bz2|tar\.Z|tar\.xz|zip|war|jar|tgz|tbz|txz|tar|iso|exe)(\?.*)?}
  Chef::Log.debug("DEBUG: file_extension is #{Regexp.last_match[2]}") if @basename =~ %r{^(.+?)\.(tar\.gz|tar\.bz2|tar\.Z|tar\.xz|zip|war|jar|tgz|tbz|txz|tar|iso|exe)(\?.*)?}
  Regexp.last_match[2] if @basename =~ %r{^(.+?)\.(tar\.gz|tar\.bz2|tar\.Z|tar\.xz|zip|war|jar|tgz|tbz|txz|tar|iso|exe)(\?.*)?}
end

def unpack_command(archfile)
  # set defaults to use if File.exists? fails.
  # It will try to use system path to run
  tarcmd = 'tar'
  gzipcmd = 'gzip'
  bzipcmd = 'bzip2'
  unzipcmd = 'unzip'
  if RUBY_PLATFORM =~ /linux/
    package 'unzip'
    tarcmd = '/bin/tar' if ::File.exist?('/bin/tar')
    unzipcmd = '/usr/bin/unzip' if ::File.exist?('/usr/bin/unzip')
  elsif RUBY_PLATFORM =~ /aix/
    gzipcmd = '/usr/local/bin/gzip' if ::File.exist?('/usr/local/bin/gzip')
    tarcmd = '/usr/bin/tar' if ::File.exist?('/usr/bin/tar')
    tarcmd = '/usr/bin/tar' if ::File.exist?('/usr/bin/tar')
    unzipcmd = '/usr/local/bin/unzip' if ::File.exist?('/usr/local/bin/unzip')
  end

  case parse_extension
  when /tar.gz|tgz|tar.Z/
    if RUBY_PLATFORM =~ /linux/
      cmd = if new_resource.target_file.nil?
              tarcmd + ' -xzf ' + archfile + ' -C ' + new_resource.target_dir
            else
              tarcmd + ' -xzf ' + archfile + ' -C ' + new_resource.target_dir + ' --wildcards --no-anchored "*' + new_resource.target_file + '" --transform "s?.*/??g"'
            end
    elsif RUBY_PLATFORM =~ /aix/
      cmd = 'cd ' + new_resource.target_dir + ' && ' + gzipcmd + ' -cd ' + archfile + ' | ' + tarcmd + ' -xf -'
    end
  when /tar.xz|txz/
    if RUBY_PLATFORM =~ /linux/
      cmd = if new_resource.target_file.nil?
              tarcmd + ' -xJf ' + archfile + ' -C ' + new_resource.target_dir
            else
              tarcmd + ' -xJf ' + archfile + ' -C ' + new_resource.target_dir + ' --wildcards --no-anchored "*' + new_resource.target_file + '" --transform "s?.*/??g"'
            end
    end
  when /tar.bz2|tbz/
    if RUBY_PLATFORM =~ /linux/
      cmd = if new_resource.target_file.nil?
              tarcmd + ' -xjf ' + archfile + ' -C ' + new_resource.target_dir
            else
              tarcmd + ' -xjf ' + archfile + ' -C ' + new_resource.target_dir + ' --wildcards --no-anchored "*' + new_resource.target_file + '" --transform "s?.*/??g"'
            end
    elsif RUBY_PLATFORM =~ /aix/
      cmd = 'cd ' + new_resource.target_dir + ' && ' + bzipcmd + ' -cd ' + archfile + ' | ' + tarcmd + ' -xf -'
    end
  when /tar/
    if RUBY_PLATFORM =~ /linux/
      cmd = if new_resource.target_file.nil?
              tarcmd + ' -xf ' + archfile + ' -C ' + new_resource.target_dir
            else
              tarcmd + ' -xf ' + archfile + ' -C ' + new_resource.target_dir + ' --wildcards --no-anchored "*' + new_resource.target_file + '" --transform "s?.*/??g"'
            end
    elsif RUBY_PLATFORM =~ /aix/
      cmd = 'cd ' + new_resource.target_dir + ' &&  ' + tarcmd + ' -xf ' + archfile
    end
  when /zip|war|jar/
    # cmd = unzipcmd + ' -u -q ' + archfile + ' -d ' + new_resource.target_dir
    cmd = unzipcmd + ' -o -q ' + archfile + ' -d ' + new_resource.target_dir
  else
    raise 'Unknown extension'
  end
  Chef::Log.debug("DEBUG: cmd: #{cmd}")
  cmd
end
