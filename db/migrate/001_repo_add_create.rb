class RepoAddCreate < ActiveRecord::Migration
  def up
	add_column :repositories, :create_repo, :integer
  end

  def down
	remove_column :repositories, :create_repo
  end
end