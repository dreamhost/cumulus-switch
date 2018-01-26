require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

if /^2\./.match os[:release]
  describe package('cl-mgmtvrf') do
    it { should be_installed }
  end
  describe command('ip route show table mgmt') do
    its(:exit_status) { should eq 0 }
  end
end
