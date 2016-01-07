class ProjectsController < ApplicationController

  # TODO: Readd this feature after student payments is live

  # REGISTERED_STUDENTS = %w(ntntnlstdnt dcmalburg zhangca1 micronaldkelly danieljhogan bucknut1600 ElizabethRoseMartin QueenPeartato spalot watkin36)
  #
  # def index
  #   students = User.where(username: REGISTERED_STUDENTS)
  #   @projects = students.map do |user|
  #     user.projects.reject do |key, properties|
  #       properties['status'] == 'approved'
  #     end.map do |key, status|
  #       OpenStruct.new(
  #         lesson: Lesson.find(key, user),
  #         status: status,
  #         user: user
  #       )
  #     end
  #   end.flatten.sort_by do |project|
  #     project.user.updated_at
  #   end.group_by { |project| project.status }
  # end
  #
  # def refresh
  #   students = User.where(username: REGISTERED_STUDENTS)
  #   students.to_a.each do |user|
  #     LessonsStatusFetcher.new(user).dictionary
  #   end
  #   redirect_to :projects
  # end

end
