require 'spec_helper'

module ForecastIO
  describe Forecast do
    before do
      ForecastIO.configure { |c| c.api_key = 'api_key' }
    end

    describe 'coordinates' do
      it 'returns current weather by geographic coordinates' do
        url = 'https://api.forecast.io/forecast/api_key/38.992393,-0.378382?exclude=offset,minutely,hourly,daily,alerts,flags'

        response = {
          'latitude' => 38.992393,
          'longitude' => -0.378382,
          'timezone' => 'Europe/Madrid',
          'offset' => 1,
          'currently' => {
            'time' => 1419536893,
            'summary' => 'Partly Cloudy',
            'icon' => 'partly-cloudy-night',
            'precipIntensity' => 0,
            'precipProbability' => 0,
            'temperature' => 52.04,
            'apparentTemperature' => 52.04,
            'dewPoint' => 42.07,
            'humidity' => 0.69,
            'windSpeed' => 3.69,
            'windBearing' => 276,
            'cloudCover' => 0.29,
            'pressure' => 1030.63,
            'ozone' => 273.39
          }
        }

        body = JSON.dump(response)
        headers = { 'Content-Type' => 'application/json' }

        stub_request(:get, url).
          to_return(status: 200, body: body, headers: headers)

        forecast = Forecast.new.coordinates(latitude: 38.992393, longitude: -0.378382, exclude: 'offset,minutely,hourly,daily,alerts,flags')

        expect(forecast.latitude).to eq(38.992393)
        expect(forecast.currently.windSpeed).to eq(3.69)
      end
    end
  end
end
