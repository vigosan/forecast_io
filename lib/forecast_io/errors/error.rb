module ForecastIO
  module Errors
    class Error
      attr_reader :message

      def initialize(message)
        @message = message
      end

      def ==(other)
        message == other.message
      end
    end
  end
end
