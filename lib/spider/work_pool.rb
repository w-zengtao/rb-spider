# 这里想引入多线程抓取 & TODO

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