# Scheduler
# 调度器，这里池里拿取等待请求的数据 & 分发处理抓取的数据
require_relative "util"

module Spider
  module Scheduler

    CTAG_HASH = "ctag_hash"           # 这里存储爬虫上一次数据的签名

    self.extend Util

    # ----------------- Call Basic Tools -----------------
    def self.work_pool
      WorkPool.instance
    end

    # ----------------- Call Basic Tools End -----------------
    def self.add(task = nil)
      work_pool.add(task)
    end

    # 判断是否需要进入处理流程
    def self.need_deal?(url, md5ed)
      return false if get(url) == md5ed   # 如果没有改变就不需要处理
      set(url, md5ed)
      return true
    end

    private
      def self.set(url, md5ed = nil)
        redis.hset(CTAG_HASH, Digest::MD5.hexdigest(url), md5ed)
      end

      def self.get(url)
        redis.hget(CTAG_HASH, Digest::MD5.hexdigest(url))
      end
  end
end


# Spider::Scheduler.work_pool
