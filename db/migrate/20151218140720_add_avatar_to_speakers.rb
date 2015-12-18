class AddAvatarToSpeakers < ActiveRecord::Migration
  def self.up
    change_table :speakers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :speakers, :avatar
  end
end
