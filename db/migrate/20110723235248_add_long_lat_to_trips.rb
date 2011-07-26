class AddLongLatToTrips < ActiveRecord::Migration
  def self.up
    add_column :trips, :origin_longitude, :decimal
    add_column :trips, :origin_latitude, :decimal
    add_column :trips, :destination_longitude, :decimal
    add_column :trips, :destination_latitude, :decimal
  end

  def self.down
    remove_column :trips, :destination_latitude
    remove_column :trips, :destination_longitude
    remove_column :trips, :origin_latitude
    remove_column :trips, :origin_longitude
  end
end
