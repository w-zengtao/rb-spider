# User Story
# 定时器应该是一个线程 & 这个线程应该在不停的轮询
# 会读取 Redis 里面的Task 如果满足时间要求就 Push 进去队列
# Hash - key: object_id & value : next_time

# Every 5 seconds、it reads tasks from redis and compare the current time and the scheduled time of the task
# Push task to Scheduler if it satisfy the time rule


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

    private
      def run_loop
        loop do
          jobs.each_pair { |key, value| push_to_queue(key) if Time.now.to_i > value.to_i }
          sleep(POLLING_TIME)
        end
      end

      def set(object_id, next_time)
        redis.hset(TIMER_STORE_KEY, object_id, next_time)
      end

      def push_to_queue(object_id = nil)
        load_task_by_id(object_id) do |task|
          Scheduler.add(task)
          reset_time_by_task(task)
        end
      end

      def jobs
        redis.hgetall(TIMER_STORE_KEY)
      end

      def reset_time_by_task(task)
        puts "Reset task: #{task.id} scheduler time to #{Time.at(Time.now.to_i + task.period)} ..."
        set(task.id, Time.now.to_i + task.period)
      end
  end
end
