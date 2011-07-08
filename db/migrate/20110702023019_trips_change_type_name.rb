class TripsChangeTypeName < ActiveRecord::Migration
  def self.up
    rename_column :trips, :type, :trip_type
  end

  def self.down
    rename_column :trips, :trip_type, :type
  end
end
