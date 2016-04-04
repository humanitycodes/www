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

end
