require 'recap/recipes/ruby'

set :application, 'blog'
set :repository,  'git://github.com/joecorcoran/blog.git'
set :branch,      'master'

server '178.79.172.127', :joecorcoran

namespace :deploy do
  task :restart do
    sudo "jekyll"
  end
end