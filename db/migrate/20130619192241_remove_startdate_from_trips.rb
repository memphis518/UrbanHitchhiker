class RemoveStartdateFromTrips < ActiveRecord::Migration
  def up
    remove_column :trips, :start_date
    remove_column :trips, :start_time
  end

  def down
    add_column :trips, :start_date, :date
    add_column :trips, :start_time, :time
  end
end
