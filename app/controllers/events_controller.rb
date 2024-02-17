# frozen_string_literal: true

# controller handle user events
class EventsController < ApplicationController
  EVENT_B = 'Create Event B'
  before_action :authenticate_user!

  def index
    @events = []
    return if current_user.blank?

    response = WIREMOCK_CLIENT.events_by_email(current_user.email)
    @events = response['events']
  rescue StandardError
    @error = true
  end

  def new; end

  def create
    WIREMOCK_CLIENT.track(event_body)

    redirect_to events_path, notice: 'Event has been Initiated Successfully'
  rescue StandardError
    flash[:error] = 'Something went wrong'
    redirect_to events_path
  end

  private

  def event_name
    params[:commit] == EVENT_B ? User::EVENT_TYPE[0] : User::EVENT_TYPE.sample
  end

  def event_body
    {
      email: current_user.email,
      userId: SecureRandom.uuid,
      eventName: event_name,
      id: SecureRandom.uuid,
      dataFields: {},
      campaignId: SecureRandom.uuid,
      templateId: SecureRandom.uuid,
      createNewFields: true
    }
  end
end
