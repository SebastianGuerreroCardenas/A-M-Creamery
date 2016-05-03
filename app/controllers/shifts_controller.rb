class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show,:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    if logged_in?
      if current_user.employee.role == "admin"
        @upcoming_shifts = Shift.upcoming.by_store.by_employee.chronological.paginate(page: params[:upcoming_page]).per_page(15)
        @past_shifts = Shift.past.by_store.by_employee.chronological.paginate(page: params[:past_page]).per_page(15)
      elsif current_user.employee.role == "manager"
        @upcoming_shifts = Shift.upcoming.for_store_current(current_user.employee.current_assignment.store.id).by_store.by_employee.chronological.paginate(page: params[:upcoming_page]).per_page(15)
        @past_shifts = Shift.past.for_store_current(current_user.employee.current_assignment.store.id).by_store.by_employee.chronological.paginate(page: params[:past_page]).per_page(15)
      else
        @upcoming_shifts = Shift.for_employee(current_user.employee.id).upcoming.by_store.by_employee.chronological.paginate(page: params[:upcoming_page]).per_page(15)
        @past_shifts = Shift.for_employee(current_user.employee.id).past.by_store.by_employee.chronological.paginate(page: params[:past_page]).per_page(15)
      end
    end
  end

  def show
    # get the shift history for this assignment (later; empty now)
     @jobs = @shift.jobs.alphabetical.paginate(page: params[:page]).per_page(5)
  end

  def new
    @shift = Shift.new
    # if params[:from].nil?
    #   if params[:id].nil?
    #     @assignment = Assignment.new
    #   else
    #     @assignment = Assignment.find(params[:id])
    #   end
    # else
    #   @assignment = Assignment.new
    #   if params[:from] == "store" 
    #     @assignment.store_id = params[:id]
    #   else
    #     @assignment.employee_id = params[:id]
    #   end
    # end
  end

  def edit
  end

  def create
    
  end

  def update
    if @shift.update(shift_params)
      redirect_to shifts_path, notice: "#{@shift.employee.proper_name}'s shift to #{@shift.store.name} is updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @shift.destroy
    redirect_to shifts_path, notice: "Successfully removed #{@shift.employee.proper_name} from #{@shift.store.name}."
  end

  private
  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :job_ids => [])
  end

end