class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.primary_key :id
      t.string :username
      t.string :password
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.boolean :active
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
