working_directory "/var/www/schaeffler-wechat"

pid "/var/www/schaeffler-wechat/pids/unicorn.pid"

stderr_path "/var/www/schaeffler-wechat/log/unicorn.err.log"
stdout_path "/var/www/schaeffler-wechat/log/unicorn.out.log"

listen "/tmp/unicorn.schaeffler-wechat.sock"

worker_processes 1

timeout 30
