class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :number
      t.bigint :chat_id, null: false
      t.timestamps
    end

    add_foreign_key :messages, :chats, column: :chat_id

    add_index :messages, :chat_id
    add_index :messages, [:chat_id, :number], unique: true
  end
end
