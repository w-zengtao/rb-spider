Dir[File.dirname(__FILE__) + "/spider/*.rb"].map { |file| require file }

module Spider
  self.extend Util

  def self.start
    clean
    load_tasks.each_key { |key| redis.hset(Timer::TIMER_STORE_KEY, key, Time.now.to_i) }
  end

  def self.clean
    redis.del(Timer::TIMER_STORE_KEY)
  end

  def self.load_tasks
    @tasks = {}
    Config.instance.config["tasks"].each do |task|
      t = Task.new(task)
      @tasks[t.id.to_s] = t
    end
    return @tasks
  end

  def self.tasks
    return @tasks
  end
end

Spider.start
# timer = Spider::Timer.new


# 定时器会定时把任务 分发给 调度器 & 调度器会把任务分发至 队列