class HomeController < ApplicationController

  def home
  end

  def dashboard
    if logged_in?
      if current_user.employee.role == "admin"
        @msg= "admin"
      elsif current_user.employee.role == "manager"
        @msg= "manager"
      else
         @msg= "employee"
      end
    end
  end

  def about
  end

  def privacy
  end

  def contact
  end

end