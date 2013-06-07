# Thanks octokit
require 'faraday'

module Faraday
  class Response::AltergeoApiError < Response::Middleware
    ERROR_MAP = {
        400 => AltergeoApi::BadRequest,
        401 => AltergeoApi::Unauthorized,
        403 => AltergeoApi::Forbidden,
        404 => AltergeoApi::NotFound,
        406 => AltergeoApi::NotAcceptable,
        422 => AltergeoApi::UnprocessableEntity,
        500 => AltergeoApi::InternalServerError,
        501 => AltergeoApi::NotImplemented,
        502 => AltergeoApi::BadGateway,
        503 => AltergeoApi::ServiceUnavailable
    }

    def on_complete(response)
      key = response[:status].to_i
      raise ERROR_MAP[key].new(response) if ERROR_MAP.has_key? key
    end
  end
end