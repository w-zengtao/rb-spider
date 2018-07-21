# 这里直接用一个单例模式来处理配置文件

require "yaml"

module Spider
  class Config

    @@instance = nil
    attr_accessor :config
    
    def initialize
      @config = YAML.load(File.open(File.expand_path("../../../config.yml", __FILE__)))
    end

    def self.instance
      @@instance ||= self.new
    end
  end
end