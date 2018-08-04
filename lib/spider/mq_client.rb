require 'bunny'
require_relative './config'

# RabbitMQ Config

module Spider
  class MqClient

    @@instance = nil

    def initialize(opts = {})
      @connection = Bunny.new({
        username: Config.instance.config["rabbitmq"]["username"],
        password: Config.instance.config["rabbitmq"]["password"],
        vhost:    Config.instance.config["rabbitmq"]["vhost"],
        host:     Config.instance.config["rabbitmq"]["host"]
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
  end
end


# mq_client = Spider::MqClient.new(exchange_name: 'your_exchange_name')

mq_client = Spider::MqClient.new
