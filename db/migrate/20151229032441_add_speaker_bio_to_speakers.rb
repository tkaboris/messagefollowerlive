class AddSpeakerBioToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :speaker_bio, :text
  end
end
