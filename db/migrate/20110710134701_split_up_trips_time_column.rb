class SplitUpTripsTimeColumn < ActiveRecord::Migration
  def self.up
    add_column :trips, 'date', :date
    remove_column :trips, :time
    add_column :trips, 'time', :time
    
  end

  def self.down
    remvoe_column :trips, 'date', :date
    remove_column :trips, 'time', :time
    add_column :trips, 'time', :timestamp
  end
end