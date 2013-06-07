require 'json'
require 'faraday'
require 'faraday_middleware'
require 'faraday/response/altergeo_api_error'
require 'addressable/uri'
require 'active_support/inflector'

module AltergeoApi
  module Request

    def api_url
      'http://altergeo.ru/openapi/v1'
    end

    def get(path, opts)
      request('get', path, opts)
    end

    def post(path, opts)
      request('post', path, opts)
    end

    protected
      def connection
        c = Faraday.new
        c.use Faraday::Response::AltergeoApiError
        c.basic_auth(@email, @password) if @email
        c
      end

      def request(method, path, opts)
        res = connection.send(method, api_url + path, opts) do |req|
          req.headers['Accept'] = 'json'
          req.headers['Accept-Language'] = opts[:language]||'ru'
        end
        JSON.parse res.body, :symbolize_names => true
      end
  end
end