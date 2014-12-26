# ForecastIO

A ruby wrapper for forecast.io API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'forecast_io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install forecast_io

## Configuration

    ForecastIO.configure do |c| 
        c.api_key = api_key
    end

## Usage

### Retrieve current weather data by geographic coordinates

    ForecastIO::Forecast.new.coordinates(latitude: 35, longitude: 139)

## Contributing

1. Fork it ( https://github.com/vigosan/forecast_io/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
