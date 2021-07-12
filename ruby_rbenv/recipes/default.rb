# Install rbenv and makes it avilable to the selected user
version = '2.7.4'

rbenv_user_install 'root'

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user 'root'
end

rbenv_ruby version do
  user 'root'
  verbose true
end

rbenv_gem 'bundler' do
  version '2.2.23'
  user 'root'
  rbenv_version version
end

rbenv_gem 'puma' do
  version '5.3.2'
  user 'root'
  rbenv_version version
end
