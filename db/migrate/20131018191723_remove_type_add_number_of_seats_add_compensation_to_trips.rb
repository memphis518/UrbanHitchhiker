class RemoveTypeAddNumberOfSeatsAddCompensationToTrips < ActiveRecord::Migration
  def up
    remove_column :trips, :trip_type
    add_column :trips, :total_seats, :integer
    add_column :trips, :seats_remaining, :integer
    add_column :trips, :compensation, :string
  end

  def down
    add_column :trips, :trip_type, :string
    remove_column :trips, :total_seats
    remove_column :trips, :seats_remaining
    remove_column :trips, :compensation
  end
end
