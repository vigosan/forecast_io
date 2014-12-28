require 'byebug'

module ForecastIO
  class Request
    attr_reader :configuration

    def initialize(configuration = ForecastIO.configuration)
      @configuration = configuration
    end

    def request(method, path, opts={})
      rescue_errors do
        path = "#{klass_name}/#{configuration.api_key}/#{path}"
        response = connection.send(method, path, opts)
        handle_response(response)
      end
    end

    private

    def connection
      conn = Faraday.new
      conn.url_prefix = configuration.host
      conn
    end

    def handle_response(response)
      return parse_response(response) if response.success?
      handle_error_response(response)
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def handle_error_response(response)
      raise ErrorHandler.new(response).handle_error
    end

    def rescue_errors
      yield
    rescue Faraday::Error::ConnectionFailed => e
      raise Errors::ConnectionError.new(e.message)
    rescue Faraday::Error::TimeoutError
      raise Errors::TimeoutError
    end

    def build_query(params)
      URI.escape(params.collect{ |k,v| "#{k}=#{v}" }.join('&'))
    end

    def klass_name
      self.class.name.split('::').last.downcase
    end
  end
end
