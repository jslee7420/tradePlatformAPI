require 'connection_pool'
# 한 번 작업이 이루어질 때, 몇 개의 ThreadPool이 생성되어 순차적으로 동시에 작업이 이루어질 것인지 설정합니다.
# size : 순번이 대기되어있는 큐를 가져와서 동시적으로 작업이 이루어질 때 몇 개의 작업이 이루어질지 설정합니다.
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 3) { Redis.new(url: Rails.configuration.x.redis.object_redis_url, logger: Rails.logger) }


# sidekiq을 여러개 생성 시, redis에 있어 충돌을 방지합니다.
Sidekiq.configure_server do |config|
    config.redis = { url: Rails.configuration.x.redis.url }
  end
   
  Sidekiq.configure_client do |config|
    config.redis = { url: Rails.configuration.x.redis.url }
  end
   
  Sidekiq.default_worker_options = {retry: 1}
