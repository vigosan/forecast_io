module ForecastIO
  class Configuration
    HOST = 'https://api.forecast.io'

    attr_accessor :api_key
    attr_reader :host

    def initialize
      @host = HOST
    end

    def reset
      @api_key = nil
    end
  end
end
