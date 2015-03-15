class AddLinkedInDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :description, :text
    add_column :users, :location, :string
    add_column :users, :headline, :string
    add_column :users, :linkedin_profile, :string
  end
end
