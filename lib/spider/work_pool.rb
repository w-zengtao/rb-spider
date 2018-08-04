# 这里想引入多线程抓取 & TODO
# which means we fetch url async through thread pools & but mq client is the only 'key'(resource or ConditionVariable)

module Spider
  class WorkPool

    # Use queue to hold messages & use threads to consume messages
    attr_accessor :threads, :queue

    def initialize(size = 10)
      @size = size
    end

    def start
      threads = []
      @size.times { threads << Thread.new(&method(:run_loop)) }
    end

    def stop

    end

    private
      def run_loop

      end
  end
end
