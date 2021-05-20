require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/bundler"
require "capistrano/rbenv"
require 'capistrano/rails/migrations'

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git


Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
