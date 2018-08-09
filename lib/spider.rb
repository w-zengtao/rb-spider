Dir[File.dirname(__FILE__) + "/spider/*.rb"].map { |file| require file }

require 'pry'

module Spider
  def self.load_tasks
    @tasks = []
    Config.instance.config["tasks"].each { |task| @tasks << Task.new(task) }
    return @tasks
  end

  def self.tasks
    return @tasks
  end
end

Spider.load_tasks
