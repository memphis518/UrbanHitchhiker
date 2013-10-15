class AddTripIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :trip_id, :integer
  end
end
