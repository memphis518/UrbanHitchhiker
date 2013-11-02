class AddDescriptionToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :description, :text
  end
end
