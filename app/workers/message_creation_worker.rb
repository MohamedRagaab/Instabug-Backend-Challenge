class MessageCreationWorker
  include Sidekiq::Worker

  def perform(chat_id, body)
    chat = Chat.find(chat_id)
    message = chat.messages.new(body: body)
    message.save!
  end
end
