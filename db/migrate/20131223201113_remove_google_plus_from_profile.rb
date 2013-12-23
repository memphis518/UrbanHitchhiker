class RemoveGooglePlusFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :googleplus, :string
  end
end
