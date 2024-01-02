class ChatCreationWorker
  include Sidekiq::Worker

  def perform(application_id)
    chat_application = ChatApplication.find(application_id)
    chat = chat_application.chats.new
    chat.save!
  end
end
