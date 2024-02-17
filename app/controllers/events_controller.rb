# frozen_string_literal: true

# controller handle user events
class EventsController < ApplicationController
  def index
    @events = []
    return if current_user.blank?

    response = WIREMOCK_CLIENT.events_by_email(current_user.email)
    @events = response['events']
  rescue StandardError
    @error = true
  end
end
