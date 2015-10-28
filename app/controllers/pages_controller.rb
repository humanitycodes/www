class PagesController < ApplicationController

  def students_guide
  end

  def landing
  end

  def staff
    @presenter = {
      staff: StaffMember.all
    }
  end

  def students
    @presenter = {
      students: Student.all
    }
  end

end
