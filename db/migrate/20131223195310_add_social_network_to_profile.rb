class AddSocialNetworkToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :twitter, :string
    add_column :profiles, :facebook, :string
    add_column :profiles, :googleplus, :string
  end
end
