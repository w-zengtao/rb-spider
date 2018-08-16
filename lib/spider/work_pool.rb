# We fetch url async through thread pools & but mq client is the only 'key'(resource or ConditionVariable)

module Spider
  class WorkPool

    @@instance = nil

    # Use queue to hold messages & use threads to consume messages
    attr_accessor :threads, :queue

    def initialize(size = 2)
      @queue, @threads = ::Queue.new, Array.new
      size.times { @threads << Thread.new(&:run_loop) }
    end

    def self.instance
      @@instance ||= self.new
    end

    def add(task = nil)
      @queue << task
    end

    private
      def run_loop
        loop do
          begin
            @queue.pop.call if @queue.size > 1
          rescue ::StandardError => e
            puts e.class.name
            puts e.message
          end
        end
      end
  end
end
