require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

describe file('/etc/cumulus') do
  it { should be_directory }
end

describe file('/etc/cumulus/ports.conf') do
  it { should be_file }
  its(:content) { should match(/# Managed by Chef/) }
  its(:content) { should match(/1=10G/) }
  its(:content) { should match(/2=40G/) }
  its(:content) { should match(/3=40G/) }
  its(:content) { should match(%r{4=40G/4}) }
  its(:content) { should match(%r{5=40G/4}) }
  its(:content) { should match(/6=4x10G/) }
  its(:content) { should match(/7=4x10G/) }
  its(:content) { should match(/8=4x10G/) }
end
