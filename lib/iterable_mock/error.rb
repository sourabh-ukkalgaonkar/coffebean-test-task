# frozen_string_literal: true

module IterableMock
  # client api error handling
  class Error < ::StandardError
    class << self
      def errors
        @errors ||= {
          400 => IterableMock::Error::BadRequest,
          401 => IterableMock::Error::Unauthorized,
          404 => IterableMock::Error::NotFound
        }
      end

      def on_complete(response)
        klass = errors[response.try(:http_code)&.to_i] || IterableMock::Error::Unknown
        raise klass.new(klass.new(response.inspect)) # rubocop:disable Style/RaiseArgs
      end
    end

    # Raised when IterableMock returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when IterableMock returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when IterableMock returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when IterableMock returns the HTTP status code 404
    NotFound = Class.new(ClientError)
  end
end
