# Scheduler
# 调度器，这里池里拿取等待请求的数据 & 分发处理抓取的数据

require "redis"

module Spider
  module Scheduler

    SCHEDULED_POOLS = "scheduled_pools"     # 调度池
    CTAG_HASH       = "ctag_hash"           # 这里存储爬虫上一次数据的签名

    def self.redis
      @redis ||= Redis.new(
        host: Config.instance.config["redis"]["url"],
        port: Config.instance.config["redis"]["port"],
        db:   Config.instance.config["redis"]["db"]
      )
    end

    def self.exec
      pools.each { |url| Fetcher.new(url).exec }
    end

    def self.pools
      pendings = redis.smembers(SCHEDULED_POOLS)
      clean
      return pendings
    end

    def self.add(url = [])
      return if url.empty?
      redis.sadd(SCHEDULED_POOLS, url)
      exec
    end

    # 这里判断是否需要进入数据处理流程
    def self.hset(url, md5ed = nil)
      redis.hset(CTAG_HASH, Digest::MD5.hexdigest(url), md5ed)
    end

    def self.hget(url)
      redis.hget(CTAG_HASH, Digest::MD5.hexdigest(url))
    end

    private
      def self.clean
        redis.del(SCHEDULED_POOLS)
      end
  end
end


# Spider::Scheduler.redis

# SortedSort 可以加入优先级处理
# Set

# Spider::Scheduler.add("http://www.baidu.com")
