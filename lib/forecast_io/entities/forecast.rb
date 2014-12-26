module ForecastIO
  module Entities
    class Forecast < Entity
      ATTRIBUTES = [
        :latitude, :longitude, :timezone, :offset, :currently, :minutely,
        :hourly, :daily, :alerts, :flags
      ]
    end
  end
end
