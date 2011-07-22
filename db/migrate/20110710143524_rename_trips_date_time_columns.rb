class RenameTripsDateTimeColumns < ActiveRecord::Migration
  def self.up
    rename_column :trips, :date, :start_date
    rename_column :trips, :time, :start_time
  end

  def self.down
    rename_column :trips, :start_date, :date
    rename_column :trips, :start_time, :time
  end
end
