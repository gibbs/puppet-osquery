require 'spec_helper'

describe 'osquery' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('osquery') }
        it { is_expected.to create_class('osquery::service') }
        it { is_expected.to create_class('osquery::package') }
        it { is_expected.to create_class('osquery::config') }

        it { is_expected.to contain_class('osquery') }
        it { is_expected.to contain_class('osquery::service') }
        it { is_expected.to contain_class('osquery::package') }
        it { is_expected.to contain_class('osquery::config') }

        if facts[:os]['family'] == 'Debian'
          it { is_expected.to contain_apt__source('osquery') }
        end

        if facts[:os]['family'] == 'RedHat'
          it { is_expected.to contain_yumrepo('osquery-s3-rpm') }
        end

        if ['Debian', 'Redhat'].include? facts[:os]['family']
          it { is_expected.to contain_file('/etc/osquery/osquery.conf') }
        end

        if facts[:os]['family'] == 'windows'
          it { is_expected.to contain_file('C:/Program Files/osquery/osquery.conf') }
        end

        it { is_expected.to contain_package('osquery') }
        it { is_expected.to contain_service('osqueryd') }
      end
    end
  end
end
