require 'spec_helper'

module ForecastIO
  module Errors
    describe RequestError do
      it 'holds response data' do
        error = RequestError.new(400, 'Error content')

        expect(error.http_status).to eq(400)
        expect(error.http_body).to eq('Error content')
      end

      it 'loads errors when present' do
        error = {
          'code' => 400,
          'error' => 'The given location (or time) is invalid'
        }
        response_json = JSON.dump(error)
        request_error = RequestError.new(400, response_json)

        expected_error = Error.new('The given location (or time) is invalid')
        expect(request_error.error).to eq(expected_error)
      end
    end
  end
end
