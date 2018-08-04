require 'bunny'

# RabbitMQ Conf

module Spider
  class MqClient

    def initialize(opts = {})
      @bunny = Bunny.new
      @channel  = @bunny.create_channel
      @exchange = @channel.fanout(opts.fetch(:exchange_name, 'spider-default'))
    end
    
    def publish
      @exchange.publish(
        
      )
    end
  end
end