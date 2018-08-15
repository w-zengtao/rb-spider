# 这里直接用一个单例模式来处理配置文件

require "yaml"

module Spider
  class Config

    @@instance = nil
    attr_accessor :config

    def initialize
      @config = YAML.load(File.open(File.expand_path("../../../config/config.yml", __FILE__)))
    end

    def self.config
      instance.config
    end

    def self.redis
      instance.config["redis"]
    end

    def self.rabbitmq
      instance.config["rabbitmq"]
    end

    def self.tasks
      instance.config["tasks"]
    end

    def self.instance
      @@instance ||= self.new
    end
  end
end
