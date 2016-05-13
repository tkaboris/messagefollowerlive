class AddLocaleToListeners < ActiveRecord::Migration
  def change
    add_column :listeners, :locale, :string, null: false, default: :en
  end
end
