Dir[File.dirname(__FILE__) + "/spider/*.rb"].map { |file| require file }

require 'pry'

module Spider

  def start
    
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

Spider.load_tasks
