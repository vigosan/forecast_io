require 'spec_helper'

module ForecastIO
  describe Configuration do
    let(:configuration) { Configuration.new }

    it 'initializes with default values' do
      expect(configuration.host).to eq(Configuration::HOST)
    end

    describe '#reset' do
      it 'resets the configuration' do
        configuration.api_key = 'API_KEY'
        configuration.reset

        expect(configuration.api_key).to be_nil
      end
    end
  end
end
