describe directory('/root/.rbenv') do
  it { should be_directory }
end

#MongoDB checks
describe systemd_service('mongod') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe mongodb_conf do
  its(["net", "port"]) { should eq 27017 }
end

describe port(27017) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '0.0.0.0' }
end

#Errbit checks
describe systemd_service('errbit') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(3003) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '0.0.0.0' }
end