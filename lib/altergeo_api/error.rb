module AltergeoApi
  class Error < StandardError

    def initialize(response=nil)
      @response = response
      super(build_error_message)
    end

    def response_body
      @response_body ||= JSON.parse @response[:body], :symbolize_names => true
    end

    protected
      def build_error_message
        return nil if @response.nil?
        "#{@response[:method].to_s.upcase} #{@response[:url].to_s}: #{@response[:status]} #{response_body[:error]}"
      end
  end

  class BadRequest < Error; end
  class Unauthorized < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
  class NotAcceptable < Error; end
  class UnprocessableEntity < Error; end
  class InternalServerError < Error; end
  class NotImplemented < Error; end
  class BadGateway < Error; end
  class ServiceUnavailable < Error; end

end