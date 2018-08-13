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
  end
end
