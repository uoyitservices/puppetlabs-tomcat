require 'spec_helper'

describe 'tomcat', :type => :class do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end
    it { should contain_class("tomcat::params") }
    it { should contain_file("/opt/apache-tomcat").with(
      'ensure' => 'directory',
      'owner'  => 'tomcat',
      'group'  => 'tomcat',
      )
    }
    it { should contain_user("tomcat").with(
      'ensure' => 'present',
      'gid'    => 'tomcat',
      )
    }
    it { should contain_group("tomcat").with(
      'ensure' => 'present'
      )
    }
  end

  context "on an unsupported OS" do
    let :facts do
      {
        :osfamily => 'windows'
      }
    end
    it do
      expect {
       should compile
      }.to raise_error(Puppet::Error, /Unsupported osfamily/)
    end
  end
end
