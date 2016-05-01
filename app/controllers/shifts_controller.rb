class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show,:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    
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
    params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes)
  end

end