class OopsTripsUserIdShouldBeInt < ActiveRecord::Migration
  def up
    remove_column :trips, :user_id
    add_column :trips, :user_id, :integer
  end

  def down
    remove_column :trips, :user_id
    add_column :trips, :user_id, :string
  end
end
