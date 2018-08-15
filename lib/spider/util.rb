require "redis"

module Spider
  module Util
    def redis
      @redis ||= Redis.new(
        host: Config.redis["url"],
        port: Config.redis["port"],
        db:   Config.redis["db"]
      )
    end

    private
      def load_task_by_id(object_id, &block)
        task = ::Spider.tasks[object_id]
        yield task if block_given?
        return task
      end

      def configs
        {

        }
      end
  end
end
