require 'bunny'
require_relative './config'

# RabbitMQ Config

module Spider
  class MqClient

    @@instance = nil

    # opts
    # opts[:exchange_name] Provide rabbitmq exchange identify, defaulted will be 'spider-default'
    def initialize(opts = {})
      @connection = Bunny.new({
        username: Config.rabbitmq["username"],
        password: Config.rabbitmq["password"],
        vhost:    Config.rabbitmq["vhost"],
        host:     Config.rabbitmq["host"]
      })
      @connection.start

      @channel  = @connection.create_channel
      @exchange = @channel.fanout(opts.fetch(:exchange_name, 'spider-default'))
    end

    def self.instance
      @@instance ||= self.new
    end

    def stop
      @channel.close
      @connection.close
    end

    def publish(message = nil)
      @exchange.publish(
        message
      )
    end

    private
      def configs
        {

        }
      end

  end
end
