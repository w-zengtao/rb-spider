require 'digest'

module Spider
  class Fetcher

    # @client: this instance will delivery message to rabbitmq
    # so once we fetched response, wo delivery it to rabbitmq through this client
    attr_accessor :client

    def initialize(url = nil)
      @url = url
    end

    def mq_client(exchange_name = nil)
      return @client ||= MqClient.instance unless exchange_name
      @client ||= MqClient.new({ exchange_name: exchange_name })
    end

    def stop
      @client.stop
    end

    def exec
      parse_resp(Requester.new(@url).get)
    end

    private
      def parse_resp(resp)
        code, headers, body = resp.code, resp.headers, resp.body
        if Scheduler.need_deal?(@url, Digest::MD5.hexdigest(body))
          write_to_middleware(body)
        end
      end

      def write_to_middleware(message)
        puts "writing message to rabbitmq ..."
        mq_client.publish(message)
      end
  end
end
