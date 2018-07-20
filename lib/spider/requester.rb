# 第一版本暂时直接只支持 Json 的请求吧

module Spider
  class Requester 
    def initialize(path, params = {})
      @path, @params = path, params.merge(base_params)
    end

    def post
      resp = Typhoeus.post(@path,
        headers: { 'Content-Type' => "application/json", "charset" => "utf-8" },
        body: @params.to_json
      )
      return resp
    end

    def get
    end

    private
      def base_params
        {

        }
      end
  end
end