# frozen_string_literal: true

# Model to store User related information
class User < ApplicationRecord
  EVENT_TYPE = %w[emailSend emailOpen emailClick emailSendSkip emailBounce emailComplaint].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
