class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :origin
      t.string :destination
      t.string :trip_type
      t.string :name
      t.date :start_date
      t.time :start_time
      t.string :transportation
      t.string :user_id

      t.timestamps
    end
  end
end
