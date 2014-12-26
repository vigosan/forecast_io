module ForecastIO
  class Configuration
    HOST = 'https://api.forecast.io'

    # https://api.forecast.io/forecast/9c3817bedc63ee7f449a8c6b5484b913/37.8267,-122.423

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
