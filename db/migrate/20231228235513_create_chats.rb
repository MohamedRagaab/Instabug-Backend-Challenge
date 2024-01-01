class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.integer :number
      t.bigint :chat_application_id, null: false
      t.integer :messages_count, default: 0
      t.timestamps
    end

    add_foreign_key :chats, :chat_applications, column: :chat_application_id

    add_index :chats, :chat_application_id
    add_index :chats, [:chat_application_id, :number], unique: true
  end
end
