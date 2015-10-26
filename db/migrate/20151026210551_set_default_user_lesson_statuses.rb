class SetDefaultUserLessonStatuses < ActiveRecord::Migration
  def change
    change_column :users, :lesson_statuses, :hstore, default: {}
    User.all.each do |user|
      user.lesson_statuses ||= {}
      user.save
    end
  end
end
