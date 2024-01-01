class CreateChatApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_applications do |t|
      t.string :name
      t.string :token
      t.integer :chats_count, default: 0
      t.timestamps
    end

    add_index :chat_applications, :token, unique: true
    add_index :chat_applications, :name
  end
end
