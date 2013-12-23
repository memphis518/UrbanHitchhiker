class AddInstagramToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :instagram, :string
  end
end
