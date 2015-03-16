class AddImageUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :image_uid, :string
  end
end
