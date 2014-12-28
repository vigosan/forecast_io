module ForecastIO
  module Errors
    class RequestError < StandardError
      attr_reader :http_status, :http_body, :error

      def initialize(http_status, http_body)
        @http_status = http_status
        @http_body = http_body
        load_error if body_has_error?
      end

      def to_s
        "Status #{http_status}: #{http_body}"
      end

      private

      def json_body
        @json_body ||= JSON.parse(http_body)
      rescue JSON::ParserError
      end

      def body_has_error?
        json_body && json_body.has_key?('error')
      end

      def load_error
        message = json_body['error']
        @error = Error.new(message)
      end
    end
  end
end
