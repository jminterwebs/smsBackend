# app/models/message.rb
class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :numberInput, type: Integer
  field :messageText, type: String
  field :twilio_id, type: String
  field :to, type: String
  field :from, type: String

  # Relations
  belongs_to :user

  # Validations
  validates :numberInput, presence: true, numericality: { greater_than_or_equal_to: 7 }
  validates :messageText, presence: true, length: { minimum: 10 }

  # Indexes
  index({ user_id: 1, created_at: -1 })
end