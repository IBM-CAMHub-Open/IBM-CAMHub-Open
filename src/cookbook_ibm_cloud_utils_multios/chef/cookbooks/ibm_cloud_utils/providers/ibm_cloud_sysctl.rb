###########################################################
#          Copyright IBM Corp. 2017, 2017
###########################################################


use_inline_resources

def whyrun_supported?
  true
end

def sysctl_template(file)
  Chef::Log.info("populating #{file}")
  ::File.open(file, 'a+') { |f| f.write("# This file is managed by Chef client. Manual modifications may be\n# overwritten the next time Chef client runs...\n") }
end

def apply_sysctl(k, v, file)
  remove_sysctl(k, file)
  ::File.open(file, 'a+') { |f| f.write("#{k} = #{v}\n") }
  execute "apply the #{k} sysctl" do
    command "sysctl -w #{k}='#{v}'"
  end
end

def remove_sysctl(k, file)
  read_file = ::File.open(file, 'r+').read
  write_file = ::File.open(file, 'w+')
  read_file.each_line do |line|
    if line.start_with?('#')
      write_file.write(line)
    else
      write_file.write(line) unless line.match(/(?<key>\S*\s*)(?<equals>\s*=\s*)(?<value>\S*\s*)/)[:key].strip.gsub(/[^0-9a-z]+/i, '') == k.gsub(/[^0-9a-z]+/i, '')
    end
  end
  write_file.close
end

action :apply do
  if node['platform_family'] == 'rhel' || node['platform_family'] == 'debian'
    unless ::File.exist?(new_resource.sysctl_file)
      Chef::Log.info("#{new_resource.sysctl_file} doesn't exist, creating...")
      sysctl_template(new_resource.sysctl_file)
    end
    apply_sysctl(new_resource.key, new_resource.value, new_resource.sysctl_file)
  end
end

action :remove do
  if node['platform_family'] == 'rhel' || node['platform_family'] == 'debian'
    if ::File.exist?(new_resource.sysctl_file)
      remove_sysctl(new_resource.key, new_resource.sysctl_file)
    end
  end
end
