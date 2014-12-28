require 'spec_helper'

module ForecastIO
  describe Request do
    let(:api_key) { 'api_key' }
    let(:client) { Request.new }

    it 'initializes with a default configuration' do
      request = ForecastIO::Request.new

      expect(request.configuration.api_key).to be_nil
    end

    it 'initializes with a custom configuration' do
      configuration = Configuration.new
      configuration.api_key = api_key

      request = Request.new(configuration)

      expect(request.configuration.api_key).to eq(api_key)
    end

    describe '#request' do
      let(:api_key) { 'api_key' }
      let(:host) { "https://api.forecast.io/request/#{api_key}/method?param=value" }

      before { ForecastIO.configure { |c| c.api_key = api_key } }

      it 'makes authenticated requests with given method and params' do
        get_stub = stub_request(:get, host).
          with(query: { param: 'value' }).
          to_return(status: 200, body: '{}')
        client.request(:get, 'method', param: 'value')

        expect(get_stub).to have_been_requested
      end

      context 'response is successful' do
        it 'returns a parsed json response' do
          data = { 'thing' => 'value' }
          response_json = JSON.dump(data)

          stub_request(:get, host).
            with(query: { param: 'value' }).
            to_return(status: 200, body: response_json)
          res = client.request(:get, 'method', param: 'value')

          expect(res).to eq(data)
        end
      end

      context 'response is not successful' do
        it 'raises errors handled by ErrorHandler' do
          stub_request(:get, host).
            with(query: { param: 'value' }).
            to_return(status: 400, body: 'The given location (or time) is invalid')

          error_handler = double(:error_handler, handle_error: 'Returned by ErrorHandler')
          allow(ErrorHandler).to receive(:new).
            with(instance_of(Faraday::Response)).
            and_return(error_handler)

          expect do
            client.request(:get, 'method', param: 'value')
          end.to raise_error('Returned by ErrorHandler')
        end
      end

      it 'raises ConnectionError when connection fails' do
        stub_request(:get, host).
          to_raise(Faraday::Error::ConnectionFailed.new('Connection error'))

        expect do
          client.request(:get, 'method', param: 'value')
        end.to raise_error(Errors::ConnectionError, 'Connection error')
      end

      it 'raises TimeoutError when connection times out' do
        stub_request(:get, host).to_timeout

        expect do
          client.request(:get, 'method', param: 'value')
        end.to raise_error(Errors::TimeoutError)
      end
    end
  end
end

