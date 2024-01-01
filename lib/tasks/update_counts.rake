namespace :update_counts do
  task :chats_and_messages_counts => :environment do
    ChatApplication.find_each do |application|
      application.update(chats_count: application.chats.count)
      application.chats.find_each do |chat|
        chat.update(messages_count: chat.messages.count)
      end
    end
  end
end
