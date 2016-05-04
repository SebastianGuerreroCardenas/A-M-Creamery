class HomeController < ApplicationController

  def home
  end

  def dashboard
    if logged_in?
      if current_user.employee.role == "admin"
        @store_id = params[:store] == nil ? 1 : params[:store]
        @store = Store.find(@store_id)
        @active_employees = Employee.active.alphabetical.for_store(@store_id).paginate(page: params[:active_page]).per_page(10)
        @upcoming_shifts = Shift.upcoming.for_store_current(@store_id).by_store.by_employee.chronological.paginate(page: params[:upcoming_page]).per_page(15)
        @incomplete_shifts = Shift.incomplete.upcoming.for_store_current(@store_id).by_store.by_employee.chronological.paginate(page: params[:incomplete_page]).per_page(15)
        @active_stores = Store.active.alphabetical.paginate(page: params[:active_page]).per_page(10)
        @upcoming_shifts_for_employee = Shift.upcoming.for_store_current(@store_id).for_employee(current_user.employee.id).by_store.by_employee.chronological.paginate(page: params[:upcoming_shifts_for_employee]).per_page(15)
      elsif current_user.employee.role == "manager"
        @active_employees = Employee.active.alphabetical.for_store(current_user.employee.current_assignment.store.id).paginate(page: params[:active_page]).per_page(10)
        @upcoming_shifts = Shift.upcoming.for_store_current(current_user.employee.current_assignment.store.id).by_store.by_employee.chronological.paginate(page: params[:upcoming_page]).per_page(15)
        @incomplete_shifts = Shift.incomplete.upcoming.for_store_current(current_user.employee.current_assignment.store.id).by_store.by_employee.chronological.paginate(page: params[:incomplete_page]).per_page(15)
        @active_stores = Store.active.alphabetical.paginate(page: params[:active_page]).per_page(10)
        @store = @current_user.employee.current_assignment.store
        @upcoming_shifts_for_employee = Shift.upcoming.for_store_current(current_user.employee.current_assignment.store.id).for_employee(current_user.employee.id).by_store.by_employee.chronological.paginate(page: params[:upcoming_shifts_for_employee]).per_page(15)
      else
        @upcoming_shifts_for_employee = Shift.upcoming.for_store_current(current_user.employee.current_assignment.store.id).for_employee(current_user.employee.id).by_store.by_employee.chronological.paginate(page: params[:upcoming_shifts_for_employee]).per_page(15)
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