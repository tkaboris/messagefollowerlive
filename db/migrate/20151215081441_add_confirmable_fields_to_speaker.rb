class AddConfirmableFieldsToSpeaker < ActiveRecord::Migration
  def up
    add_column :speakers, :confirmation_token, :string
    add_column :speakers, :confirmed_at, :datetime
    add_column :speakers, :confirmation_sent_at, :datetime
    add_column :speakers, :unconfirmed_email, :string
  end

  def down
    remove_column :speakers, :confirmation_token, :string
    remove_column :speakers, :confirmed_at, :datetime
    remove_column :speakers, :confirmation_sent_at, :datetime
    remove_column :speakers, :unconfirmed_email, :string
  end
end
