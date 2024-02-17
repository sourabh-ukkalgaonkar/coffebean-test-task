# frozen_string_literal: true

module Api
  # module to write all apis
  module Events
    def track(body)
      post('events/track', body.to_json)
    end

    def events_by_email(email)
      get("events/#{email}")
    end
  end
end
