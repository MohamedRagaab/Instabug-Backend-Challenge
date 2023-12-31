class ChatApplication < ApplicationRecord
  before_create :generate_token

  has_many :chats

  validates :name, presence: true

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end
