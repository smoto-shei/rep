# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
if defined?(Unicorn)
  require 'unicorn/worker_killer'
  use Unicorn::WorkerKiller::MaxRequests, 3072, 4096, true #ワーカーが処理したリクエストの数に基づいて、Unicornワーカーを自動的に再起動します。 trueオプションでunicorn.stderr.logにログを出力します。
  use Unicorn::WorkerKiller::Oom, (192*(1024**2)), (256*(1024**2)) # メモリサイズに基づいてUnicornワーカーを自動的に再起動します。
end


require ::File.expand_path('../config/environment', __FILE__) # この記述の上に書くこと！
run Rails.application
