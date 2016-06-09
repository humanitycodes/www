class PagesController < ApplicationController

  def students_guide
  end

  def landing
    render 'landing.html.erb', layout: false
  end

  def staff
    @presenter = {
      staff: StaffMember.all
    }
  end

end
