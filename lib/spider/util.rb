require "redis"

module Spider
  module Util
    def redis
      @redis ||= Redis.new(
        host: Config.instance.config["redis"]["url"],
        port: Config.instance.config["redis"]["port"],
        db: Config.instance.config["redis"]["db"],
      )
    end

    private
      def load_task_by_id(object_id)
        ::Spider.tasks[object_id]
      end

      def configs
        {

        }
      end
  end
end
