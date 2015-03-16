class AddGithubProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_profile, :string
  end
end
