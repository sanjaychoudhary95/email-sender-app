class CreateEmailSenders < ActiveRecord::Migration[6.0]
  def change
    create_table :email_senders do |t|
      t.string :name
      t.string :email
      t.text :message
      t.integer :status

      t.timestamps
    end

    add_index :email_senders, :email
    add_index :email_senders, :status
  end
end
