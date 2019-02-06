#
# Cookbook:: beats
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'beats::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should run apt update' do
      expect(chef_run).to update_apt_update('update')
    end

    it 'should run bash to wget the key for elastic stack' do
      expect(chef_run).to add_apt_repository('elastic-co')
    end

    it 'should add the elastic stack to the sources list' do
      expect(chef_run).to run_bash('wget_elastic')
    end

    it "should install apt-transport-https" do
      expect(chef_run).to install_package("apt-transport-https")
    end

    it "should install filebeat" do
      expect(chef_run).to install_package("filebeat")
    end

    it "should install metricbeat" do
      expect(chef_run).to install_package("metricbeat")
    end

    it "should delete filebeat.yml" do
      expect(chef_run).to delete_file("/etc/filebeat/filebeat.yml")
    end

    it "should delete metricbeat.yml" do
      expect(chef_run).to delete_file("/etc/metricbeat/metricbeat.yml")
    end

    it "should create a filebeat.yml template in /etc/filebeat/filebeat.yml" do
     expect(chef_run).to create_template("/etc/filebeat/filebeat.yml")
    end

    it "should create a metricbeat.yml template in /etc/metricbeat/metricbeat.yml" do
     expect(chef_run).to create_template("/etc/metricbeat/metricbeat.yml")
    end

    it "should start the filebeat service" do
     expect(chef_run).to start_service("filebeat")
    end

    it "should start the metricbeat service" do
     expect(chef_run).to start_service("metricbeat")
    end

    it "should enable the filebeat service" do
     expect(chef_run).to enable_service("filebeat")
    end

    it "should enable the metricbeat service" do
     expect(chef_run).to enable_service("metricbeat")
    end
  end
end
