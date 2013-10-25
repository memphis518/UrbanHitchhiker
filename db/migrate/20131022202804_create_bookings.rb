class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :trip_id
      t.integer :user_id

      t.timestamps
    end
  end
end
