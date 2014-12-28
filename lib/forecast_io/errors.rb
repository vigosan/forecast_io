require 'forecast_io/errors/error'
require 'forecast_io/errors/request_error'

module ForecastIO
  module Errors
    class Forbidden < RequestError; end
    class InvalidParams < RequestError; end
    class ConnectionError < StandardError; end
    class TimeoutError < StandardError; end
  end
end
