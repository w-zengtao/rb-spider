# Scheduler
# 调度器，这里每分钟从池里拿取等待请求的数据

require "redis"

module Spider
  module Scheduler
    class << self
      def redis 
        @redis ||= Redis.new(
          host: Config.instance.config["redis"]["url"],
          port: Config.instance.config["redis"]["port"],
          db:   Config.instance.config["redis"]["db"]
        )
      end

      #  这里是执行的入口
      def exec
        pools.each do |url|
          Fetcher.new(url).exec
        end
      end

      def pools
        pendings = redis.smembers("scheduled_pools")
        clean
        return pendings
      end

      # 每次有数据进来的时候自动调用 & url 是 Array 格式
      def add(url = [])
        return if url.empty?
        redis.sadd("scheduled_pools", url)
        exec
      end

      private
        def clean 
          redis.del("scheduled_pools")
        end
    end
  end
end


# Spider::Scheduler.redis

# SortedSort 可以加入优先级处理
# Set

# Spider::Scheduler.add("http://www.baidu.com")