#
# Cookbook:: errbit
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

workdir = '/opt/errbit'

git workdir do
  repository 'https://github.com/stanislaff86/errbit.git'
  revision 'master'
  action :sync
end

execute 'Install the gems' do
  command 'bundle install'
  cwd workdir
end

execute 'the rake script' do
  command 'bundle exec rake errbit:bootstrap'
  cwd workdir
end

systemd_unit 'errbit.service' do
  content({Unit: {
            Description: 'Errbit server',
            After: 'network.target'
          },
          Service: {
            Type: 'simple',
            WatchdogSec: '10',
            ExecStart: '/root/.rbenv/shims/bundle exec rails server -b 0.0.0.0',
            Restart: 'on-failure',
            PIDFile: '/tmp/errbit.pid',
            WorkingDirectory: '/opt/errbit'
          },
          Install: {
            WantedBy: 'multi-user.target'
          }})
  action [:create, :enable, :start]
end


#execute 'start server' do
#  command 'bundle exec rails server -b 0.0.0.0 -d'
#  cwd workdir
#end
