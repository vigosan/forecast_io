module ForecastIO
  class Forecast < Request
    def coordinates(latitude:, longitude:, **opts)
      path = "forecast/#{ForecastIO.configuration.api_key}/#{latitude},#{longitude}"
      path << "?#{build_query(opts)}" if opts.any?
      res = request(:get, path)
      build_forecast(res)
    end

    private

    def build_forecast(attrs)
      Entities::Forecast.new(attrs)
    end
  end
end
