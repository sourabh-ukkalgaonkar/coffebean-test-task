# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :request do
  include_context 'common'

  describe 'GET /index' do
    context 'with sign_in' do
      before(:each) do
        sign_in user
      end

      it 'should fetch events of logged in user' do
        VCR.use_cassette('user_events') do
          get events_path

          expect(response.status).to be(200)
          expect(assigns[:events].present?).to be_truthy
        end
      end

      it 'should not fetch events due api failure' do
        allow_any_instance_of(IterableMock::Client)
          .to receive(:events_by_email).and_raise(IterableMock::Error::Unauthorized)

        get events_path

        expect(response.status).to be(200)
        expect(assigns[:events].present?).to be_falsey
        expect(assigns[:error]).to be_truthy
      end
    end

    context 'without sign_in' do
      it 'should not fetch events without user login' do
        get events_path

        expect(response.status).to be(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /new' do
    it 'should render new template' do
      sign_in user
      get new_event_path

      expect(response).to render_template(:new)
    end
  end

  describe 'GET /create' do
    context 'with sign_in' do
      before(:each) do
        sign_in user
      end

      it 'should intiate event b', vcr: true do
        VCR.use_cassette('event_email_open') do
          post events_path, params: { commit: EventsController::EVENT_B }

          expect(response.status).to be(302)
          expect(response).to redirect_to(events_path)
        end
      end

      it 'should intiate event b with email', vcr: true do
        VCR.use_cassette('event_email_open') do
          expect { post events_path, params: { commit: EventsController::EVENT_B } }.to change {
                                                                                          ActionMailer::Base.deliveries.count
                                                                                        }.by(1)
        end
      end

      it 'should intiate event a', vcr: true do
        VCR.use_cassette('event_email_other') do
          post events_path, params: { commit: event_a }

          expect(response.status).to be(302)
          expect(response).to redirect_to(events_path)
        end
      end

      it 'should not intiate event a with email', vcr: true do
        VCR.use_cassette('event_email_other') do
          expect { post events_path, params: { commit: event_a } }.to change {
                                                                        ActionMailer::Base.deliveries.count
                                                                      }.by(0)
        end
      end
    end
  end
end
