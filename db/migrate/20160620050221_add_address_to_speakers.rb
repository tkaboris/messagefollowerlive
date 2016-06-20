class AddAddressToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :address, :string
    add_column :speakers, :city, :string
    add_column :speakers, :state, :string
    add_column :speakers, :zipcode, :integer
  end
end
