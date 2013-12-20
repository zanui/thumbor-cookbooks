require 'chefspec'

describe 'stackdriver::default' do
  context 'raise exception' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'when attributes for platform are not defined' do
      expect(Chef::Formatters::ErrorMapper).to_not receive(:file_load_failed)
      expect { chef_run }.to raise_error('There does not appear to be a repository available for your platform.')
    end
  end
  context 'fedora platform' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09').converge(described_recipe) }

    it 'create yum repo' do
      expect(chef_run).to create_remote_file('/etc/yum.repos.d/stackdriver.repo')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to install_package('stackdriver-agent')
    end
  end

  context 'ubuntu platform' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '10.04').converge(described_recipe) }

    it 'create apt repo' do
      pending 'apt_repository resource has no spec matcher'
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to install_package('stackdriver-agent')
    end
  end

  context 'general configuration' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09').converge(described_recipe) }

    it 'setup service' do
      expect(chef_run).to enable_service('stackdriver-agent')
    end

    it 'create stackdriver-agent config template' do
      expect(chef_run).to create_template(chef_run.node[:stackdriver][:config_path])
    end

    it 'template should notify service' do
      template = chef_run.template(chef_run.node[:stackdriver][:config_path])
      expect(template).to notify('service[stackdriver-agent]').to(:restart)
    end
  end

  context 'disable' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09') }

    before do
      chef_run.node.set[:stackdriver][:enable] = false
      chef_run.converge(described_recipe)
    end

    it 'not to create yum repo' do
      expect(chef_run).not_to create_remote_file('/etc/yum.repos.d/stackdriver.repo')
    end

    it 'not to install stackdriver-agent' do
      expect(chef_run).not_to install_package('stackdriver-agent')
    end

    it 'not to setup service' do
      expect(chef_run).not_to enable_service('stackdriver-agent')
    end

    it 'not to create stackdriver-agent config template' do
      expect(chef_run).not_to create_template(chef_run.node[:stackdriver][:config_path])
    end
  end
end