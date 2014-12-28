require 'spec_helper'

describe ForecastIO do
  describe '.configure' do
    it 'sets the configuration' do
      api_key = 'KEY'
      ForecastIO.configure { |c| c.api_key = api_key }

      expect(ForecastIO.configuration.api_key).to eq(api_key)
    end
  end

  describe '.reset' do
    it 'resets the configuration' do
      expect(ForecastIO.configuration).to receive(:reset).at_least(:once)

      ForecastIO.reset
    end
  end
end
