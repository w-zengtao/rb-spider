# User Story
# This class has the ablility to extend fetcher behaviors & json & html & diffrent queue and so on

module Spider
  class Task

    attr_accessor :id, :type, :url, :period, :enable, :params

    # opts
    # type   : json(default) or xml
    # enable : true(default) or false
    # period : fetch url every #{period} seconds

    def initialize(opts = {})
      @type   = opts.fetch('type', 'json')
      @url    = opts.fetch('url', nil)
      @period = opts.fetch('period', 60)
      @enable = opts.fetch('enable', true)
      @params = opts.fetch('params', nil)
      @id     = self.object_id
    end

    def exec
      Fetcher.new(@url).call
    end
    alias call exec
  end
end

# @queue_name = opts.fetch('queue_name', 'spider-task-default')
# JSON 的话严格上来说只是读取 APi 还需要 APi的查询参数蔡比较合理
