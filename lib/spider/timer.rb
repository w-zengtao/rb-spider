# User Story
# 定时器应该是一个线程 & 这个线程应该在不停的轮询
# 会读取 Redis 里面的Task 如果满足时间要求就 Push 进去队列

require_relative "util"

module Spider
  class Timer
    include Util

    TIMER_STORE_KEY = "spider-timer"
    POLLING_TIME = 5

    attr_reader :thread

    def initialize
      @thread = Thread.new(&method(:run_loop))
    end

    def set(object_id, next_time)
      redis.hset(TIMER_STORE_KEY, object_id, next_time)
    end

    # private
    def run_loop
      loop do
        jobs.each_pair { |key, value| push_to_queue(key) if Time.now.to_i > value.to_i }
        sleep(POLLING_TIME)
      end
    end

    def push_to_queue(object_id = nil)
      task = load_task_by_id(object_id)
      Proc.new { Scheduler.add(task) }.call if task
    end

    def jobs
      redis.hgetall(TIMER_STORE_KEY)
    end

    def load_task_by_id(object_id)
      ::Spider.tasks[object_id]
    end
  end
end

# Every 5 seconds、it reads tasks from redis and compare the current time and the scheduled time of the task
# Push task to Scheduler if it satisfy the time rule

# Hash - key: object_id & value : next_time
