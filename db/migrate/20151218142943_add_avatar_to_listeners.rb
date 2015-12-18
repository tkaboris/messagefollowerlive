class AddAvatarToListeners < ActiveRecord::Migration
  def self.up
    change_table :listeners do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :listeners, :avatar
  end
end
