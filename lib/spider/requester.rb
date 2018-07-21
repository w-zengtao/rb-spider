# Requester
# 网络请求类, 所有的网络请求在这里出去

# 第一版本暂时直接只支持 Json 的请求吧
require "json"
require "typhoeus"

module Spider
  class Requester 
    def initialize(path, headers = {}, params = {})
      @path, @headers, @params = path, headers, params.merge(base_params)
    end

    def post
      resp = Typhoeus.post(@path,
        headers: { 'Content-Type' => "application/json", "charset" => "utf-8" },
        body: @params.to_json
      )
      return resp
    end

    def get
      resp = Typhoeus.get(@path,
        headers: { 'Content-Type' => "application/json", "charset" => "utf-8" },
        params: @params
      )
      return resp
    end

    private
      def base_params
        {

        }
      end
  end
end

# Spider::Requester.new("http://localhost:3001/api/currency_exchanges")