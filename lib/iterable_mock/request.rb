# frozen_string_literal: true

# module for request handler
module IterableMock
  # class to call get and post request
  class Request
    def get(url)
      response = RestClient.get(request_url(url), headers)
      JSON.parse(response.body)
    rescue StandardError => e
      IterableMock::Error.on_complete(e)
    end

    def post(url, params = {})
      response = RestClient.post(request_url(url), params, headers)
      JSON.parse(response.body)
    rescue StandardError => e
      IterableMock::Error.on_complete(e)
    end
  end
  Dir[Rails.root.join('lib', 'iterable_mock', 'api', '*.rb')].each { |f| require_dependency f }
end
