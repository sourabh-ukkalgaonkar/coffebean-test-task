# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IterableMock::Client do
  include_context 'common'

  it 'should track event', vcr: true do
    VCR.use_cassette('event_email_open') do
      response = client.track(email_open_body)
      expect(response).to be_truthy
      expect(response['msg']).to eq(email_open_success_msg)
    end
  end

  it 'should fetch user events', vcr: true do
    VCR.use_cassette('user_events') do
      response = client.events_by_email(email)

      expect(response).to be_truthy
      expect(response['events'].present?).to be_truthy
      expect(response['events'].count).to be(3)
    end
  end
end
