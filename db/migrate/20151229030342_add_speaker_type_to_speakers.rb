class AddSpeakerTypeToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :speaker_type, :string
  end
end
