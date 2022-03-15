require 'spec_helper_acceptance'

describe 'include class' do
  pp = <<-MANIFEST
    include osquery
  MANIFEST

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe file('/etc/osquery/osquery.conf') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_mode 6_40 }
    it { is_expected.to be_owned_by 'root' }
  end

  describe service('osqueryd') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
