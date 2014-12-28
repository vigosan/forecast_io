require 'json'
require 'faraday'

require 'forecast_io/version'
require 'forecast_io/configuration'
require 'forecast_io/entities/entity'
require 'forecast_io/entities/forecast'
require 'forecast_io/errors'
require 'forecast_io/error_handler'
require 'forecast_io/request'
require 'forecast_io/forecast'

module ForecastIO
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      configuration.reset
    end
  end
end
