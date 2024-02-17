# frozen_string_literal: true

module IterableMock
  # client to call api
  class Client < Request
    attr_accessor :base_url, :api_key

    include ::Api::Events

    def initialize
      @base_url = Rails.application.credentials.dig(:iterable_mock, :base_url)
      @api_key =  Rails.application.credentials.dig(:iterable_mock, :api_key)
    end

    private

    def request_url(path)
      "#{base_url}/api/#{path}"
    end

    def headers
      { "x-access-token": api_key, 'Content-Type': 'application/json' }
    end
  end
end
