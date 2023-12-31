# db/migrate/xxxxxxxxxxxxxx_create_chat_applications.rb
class CreateChatApplications < ActiveRecord::Migration[7.1] # Use your Rails version
  def change
    create_table :chat_applications do |t|
      t.string :name
      t.string :token
      t.integer :chats_count
      t.timestamps
    end
  end
end
