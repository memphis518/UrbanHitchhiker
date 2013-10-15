class RemoveLatitudeAndLongitudeFromTrips < ActiveRecord::Migration
  def up
    remove_column :trips, :longitude
    remove_column :trips, :latitude
  end

  def down
    add_column :trips, :latitude, :float
    add_column :trips, :longitude, :float
  end
end
