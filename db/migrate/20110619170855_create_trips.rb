class CreateTrips < ActiveRecord::Migration
  def self.up
    create_table :trips do |t|
      t.primary_key :id
      t.string :origin
      t.string :destination
      t.string :type
      t.string :name
      t.timestamp :time
      t.text :comments
      t.string :transportation
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :trips
  end
end
