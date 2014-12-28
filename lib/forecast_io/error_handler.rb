module ForecastIO
  class ErrorHandler
    def self.handle_error(response)
      new(response).handle_error
    end

    def initialize(response)
      @response = response
    end

    def handle_error
      error_class = find_error_class
      error_class.new(response.status, response.boby)
    end

    private

    def find_error_class
      case response.status
      when 400 then return Errors::InvalidParams
      when 403 then return Errors::Forbidden
      end
    end
  end
end
