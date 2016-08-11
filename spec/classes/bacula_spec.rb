require 'spec_helper'

describe 'bacula', :type => :class do

  context 'with defaults for all parameters' do
    it { should contain_class('bacula') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {
        {
          :type_fd => true,
          :type_sd => true,
          :type_dir => true,
          :backup_clients => [ 'client01.example.local', 'client02.example.local' ]
        }
      }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('bacula::package') }
      it { is_expected.to contain_class('bacula::package::common') }
      it { is_expected.to contain_class('bacula::package::file') }
      it { is_expected.to contain_class('bacula::package::storage') }
      it { is_expected.to contain_class('bacula::package::director') }
      it { is_expected.to contain_class('bacula::params') }
      it { is_expected.to contain_class('bacula::config') }
      it { is_expected.to contain_class('bacula::config::user') }
      it { is_expected.to contain_class('bacula::config::file') }
      it { is_expected.to contain_class('bacula::config::storage') }
      it { is_expected.to contain_class('bacula::config::mysql') }
      it { is_expected.to contain_class('bacula::config::director') }
      it { is_expected.to contain_class('bacula::service') }
      it { is_expected.to contain_class('bacula::service::file') }
      it { is_expected.to contain_class('bacula::service::storage') }
      it { is_expected.to contain_class('bacula::service::director') }

      it { is_expected.to contain_package('bacula-common').with_ensure('installed') }
      it { is_expected.to contain_package('bacula-client').with_ensure('installed') }
      it { is_expected.to contain_package('bacula-storage-common').with_ensure('installed') }
      it { is_expected.to contain_package('bacula-storage-mysql').with_ensure('installed') }
      it { is_expected.to contain_package('bacula-director-common').with_ensure('installed') }
      it { is_expected.to contain_package('bacula-director-mysql').with_ensure('installed') }
      it { is_expected.to contain_package('bacula-console').with_ensure('installed') }

      it { is_expected.to contain_package('bzip2').with_ensure('present') }

      it { is_expected.to contain_file('/etc/bacula/conf.d').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/clients').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/jobs').with_ensure('directory') }

      it { is_expected.to contain_file('/etc/bacula/bacula-fd.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/bacula-sd.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/bacula-dir.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/catalog.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/client-director.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/console.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/director.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/fileset.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/job-backup-catalog.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/job-director.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/job-restore.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/jobdefs.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/messages.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/pool.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/schedule.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/storage.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/populate_bacula_schema.sh').with_ensure('file') }

      it { is_expected.to contain_file('/etc/bacula/conf.d/clients/client01.example.local.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/jobs/client01.example.local.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/clients/client02.example.local.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/bacula/conf.d/jobs/client02.example.local.conf').with_ensure('file') }

      it { is_expected.to contain_service('bacula-fd').with( 'ensure' => 'running', 'enable' => 'true') }
      it { is_expected.to contain_service('bacula-sd').with( 'ensure' => 'running', 'enable' => 'true') }
      it { is_expected.to contain_service('bacula-dir').with( 'ensure' => 'running', 'enable' => 'true') }

      it { is_expected.to contain_exec('/etc/bacula/populate_bacula_schema.sh') }

      it { is_expected.to contain_user('bacula') }
      it { is_expected.to contain_group('bacula') }

      it { is_expected.to contain_Bacula__Config__Client('client01.example.local') }
      it { is_expected.to contain_Bacula__Config__Client('client02.example.local') }

      it { is_expected.to contain_Mysql_database('bacula') }
      it { is_expected.to contain_Mysql_grant('bacula@localhost/bacula.*') }
      it { is_expected.to contain_Mysql_user('bacula@localhost') }

      it 'should generate valid content for bacula-fd.conf' do
        content = catalogue.resource('file', '/etc/bacula/bacula-fd.conf').send(:parameters)[:content]
        expect(content).to match('client-password-for-bacula')
        expect(content).to match('monitor-password-for-bacula')
        expect(content).to match('FDport')
        expect(content).to match('FDAddress')
      end

      it 'should generate valid content for bacula-sd.conf' do
        content = catalogue.resource('file', '/etc/bacula/bacula-sd.conf').send(:parameters)[:content]
        expect(content).to match('storage-password-for-bacula')
        expect(content).to match('monitor-password-for-bacula')
        expect(content).to match('SDPort')
        expect(content).to match('SDAddress')
      end

      it 'should generate valid content for bacula-dir.conf' do
        content = catalogue.resource('file', '/etc/bacula/bacula-dir.conf').send(:parameters)[:content]
        expect(content).to match('director.conf')
        expect(content).to match('console.conf')
        expect(content).to match('storage.conf')
        expect(content).to match('catalog.conf')
        expect(content).to match('messages.conf')
        expect(content).to match('pool.conf')
        expect(content).to match('schedule.conf')
        expect(content).to match('fileset.conf')
        expect(content).to match('jobdefs.conf')
        expect(content).to match('/etc/bacula/conf.d/clients')
        expect(content).to match('/etc/bacula/conf.d/jobs')
      end

      case facts[:osfamily]
      when 'RedHat'
      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
