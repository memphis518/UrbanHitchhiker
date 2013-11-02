class RemoveTransportationFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :transportation
  end

  def down
    add_column :profiles, :transportation, :string
  end
end
