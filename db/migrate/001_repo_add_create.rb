class RepoAddCreate < ActiveRecord::Migration[4.2]
  def up
	add_column :repositories, :create_repo, :integer
  end

  def down
	remove_column :repositories, :create_repo
  end
end