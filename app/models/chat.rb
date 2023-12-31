class Chat < ApplicationRecord
  belongs_to :chat_application, foreign_key: 'chat_application_id'

  has_many :messages

  before_create :set_number

  private

  def set_number
    last_chat = chat_application.chats.order(number: :desc).first
    self.number = last_chat ? last_chat.number + 1 : 1
  end
end
