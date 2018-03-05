# ChefSpec matchers

Used to enabled ChefSpec unit testing of other cookbooks that rely
on LWRPs provided by this cookbook

## tar_ibm_cloud_utils_tar

### Excample Recipe

```ruby
ibm_cloud_utils_tar "Create_#{evidence_tar}" do
  source "#{evidence_dir}/#{evidence_log}"
  target_tar evidence_tar
  only_if { Dir.glob("#{node['ibm']['evidence_path']['unix']}/#{cookbook_name}*.tar").empty? }
end
```

### Example ChefSpec

```ruby
it 'tar evidence' do
  expect(chef_run).to tar_ibm_cloud_utils_tar("Create_example.tar").with(
    source: '/var/log/ibm_cloud/evidence/im-test.ibm.com.log',
    target_tar: 'example.tar'
  )
end
```

