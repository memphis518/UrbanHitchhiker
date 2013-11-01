class RemoveOriginAndDestinationFromTrip < ActiveRecord::Migration
  def up
    remove_column :trips, :origin
    remove_column :trips, :destination
  end

  def down
    add_column :trips, :destination, :integer
    add_column :trips, :origin, :integer
  end
end
