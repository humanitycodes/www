class AddLessonStatusesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lesson_statuses, :hstore
    add_index :users, :lesson_statuses, using: :gin
  end
end
