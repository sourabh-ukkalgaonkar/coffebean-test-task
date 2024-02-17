# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_context 'common' do
  let(:user)  { create(:user) }
  let(:email) { 'tester@yopmail.com' }
  let(:client) { IterableMock::Client.new }
  let(:email_open_option) { 'emailOpen' }
  let(:email_open_event_body) do
    {
      email: email,
      userId: SecureRandom.uuid,
      eventName: email_open_option,
      id: SecureRandom.uuid,
      dataFields: {},
      campaignId: SecureRandom.uuid,
      templateId: SecureRandom.uuid,
      createNewFields: true
    }
  end

  let(:email_open_success_msg) do
    "#{email_open_event_body[:eventName]} event has been created for the #{email_open_event_body[:email]} address"
  end
end
