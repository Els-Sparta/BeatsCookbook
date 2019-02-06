# # encoding: utf-8

# Inspec test for recipe beats::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package 'filebeat' do
  it { should be_installed }
  its('version') { should match /6\.4/ }
end

describe package 'metricbeat' do
  it { should be_installed }
  its('version') { should match /6\.4/ }
end

describe bash("wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -") do
  its('exit_status') { should eq 0 }
end

describe file("/etc/filebeat/filebeat.yml") do
  it { should exist }
end

describe file("/etc/metricbeat/metricbeat.yml") do
  it { should exist }
end

describe service("filebeat") do
  it { should be_enabled }
  it { should be_running }
end

describe service("metricbeat") do
  it { should be_enabled }
  it { should be_running }
end
