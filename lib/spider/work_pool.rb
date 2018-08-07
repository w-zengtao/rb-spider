# 这里想引入多线程抓取 & TODO
# which means we fetch url async through thread pools & but mq client is the only 'key'(resource or ConditionVariable)

module Spider
  class WorkPool

    # Use queue to hold messages & use threads to consume messages
    attr_accessor :threads, :queue, :started

    def initialize(size = 10)
      @size, @started, @queue = size, false, ::Queue.new
      start
    end

    def start
      threads = []
      @size.times { threads << Thread.new(&method(:run_loop)) }
      @started = true
    end

    def started?
      self.started
    end

    def stop

    end

    private
      def run_loop
        callable = @queue.pop
        begin
          callable.call
        rescue ::StandardError => error

        end
      end
  end
end
