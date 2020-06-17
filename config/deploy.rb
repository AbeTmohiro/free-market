# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.12.1'

# 自身のアプリ名、リポジトリ名を記述
set :application, 'free-market'
set :repo_url,  'git@github.com:AbeTmohiro/free-market.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.5'

# chat-spaceで使ったpemを指定
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/free-market.pem']

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :linked_files, %w{ /config/credentials/production.key }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end

  desc 'upload production.key'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/credentials/production.key', "#{shared_path}/config/production.key")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end
