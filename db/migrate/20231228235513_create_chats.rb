# db/migrate/xxxxxxxxxxxxxx_create_chats.rb
class CreateChats < ActiveRecord::Migration[7.1] # Use your Rails version
  def change
    create_table :chats do |t|
      t.integer :number
      t.bigint :chat_application_id, null: false
      t.integer :messages_count
      t.timestamps
    end

    add_foreign_key :chats, :chat_applications, column: :chat_application_id
  end
end
