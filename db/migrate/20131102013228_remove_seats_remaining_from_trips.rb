class RemoveSeatsRemainingFromTrips < ActiveRecord::Migration
  def up
    remove_column :trips, :seats_remaining
  end

  def down
    add_column :trips, :seats_remaining, :integer
  end
end
