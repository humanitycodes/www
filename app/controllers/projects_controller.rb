class ProjectsController < ApplicationController

  REGISTERED_STUDENTS = %w(ntntnlstdnt dcmalburg zhangca1 micronaldkelly danieljhogan bucknut1600 ElizabethRoseMartin QueenPeartato spalot watkin36)

  def index
    @projects = User.where(username: REGISTERED_STUDENTS).map do |user|
      user.lesson_statuses.reject do |key, status|
        status == 'approved'
      end.map do |key, status|
        OpenStruct.new(
          lesson: Lesson.find(key, user),
          status: status,
          user: user
        )
      end
    end.flatten.sort_by do |project|
      project.user.updated_at
    end.group_by { |project| project.status }
  end

end
