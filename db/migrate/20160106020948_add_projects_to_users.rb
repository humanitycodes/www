class AddProjectsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :projects, :json, null: false, default: {}
  end
end
