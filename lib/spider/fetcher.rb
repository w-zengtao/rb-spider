require 'digest'

module Spider
  class Fetcher
    def initialize(url)
      @url = url
    end

    def exec
      parse_resp(Requester.new(@url).get)
    end

    private
      def parse_resp(resp)
        code, headers, body = resp.code, resp.headers, resp.body
        if Scheduler.hget(@url) == Digest::MD5.hexdigest(body)

        else
          Scheduler.set(@url, Digest::MD5.hexdigest(body))
          write_to_middleware
        end
      end

      def write_to_middleware

      end
  end
end
