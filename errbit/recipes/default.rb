#
# Cookbook:: errbit
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

config = node['errbit']['config']

git config['workdir'] do
  repository 'https://github.com/stanislaff86/errbit.git'
  revision 'master'
  action :sync
end

execute 'Install the gems' do
  command '/root/.rbenv/shims/bundle install'
  cwd config['workdir']
end

execute 'the rake script' do
  command '/root/.rbenv/shims/bundle exec rake errbit:bootstrap'
  cwd config['workdir']
end

systemd_unit 'errbit.service' do
  content({Unit: {
            Description: 'Errbit server',
            After: 'network.target'
          },
          Service: {
            Type: 'simple',
            ExecStart: "/root/.rbenv/shims/bundle exec rails server -b #{config['bindIp']} -p #{config['port']}",
            Restart: 'on-failure',
            PIDFile: '/tmp/errbit.pid',
            WorkingDirectory: config['workdir']
          },
          Install: {
            WantedBy: 'multi-user.target'
          }})
  action [:create, :enable, :start]
end

