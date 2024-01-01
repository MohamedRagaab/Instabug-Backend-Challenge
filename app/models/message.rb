class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, foreign_key: 'chat_id'

  before_create :set_number

  validates :body, presence: true

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :body, type: 'text', analyzer: 'english'
      indexes :number, type: 'integer'
      indexes :chat_id, type: 'integer'
    end
  end

  def as_indexed_json(_options = {})
    {
      'body' => body,
      'number' => number,
      'chat_id' => chat_id
    }
  end

  private

  def set_number
    last_message = chat.messages.order(number: :desc).first
    self.number = last_message ? last_message.number + 1 : 1
  end
end
