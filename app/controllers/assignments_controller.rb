class AssignmentsController < ApplicationController
  # before_action :set_assignment, only: [:edit, :update, :destroy]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource


  def index
    if logged_in?
      if current_user.employee.role == "admin"
        @current_assignments = Assignment.current.by_store.by_employee.chronological.paginate(page: params[:current_page]).per_page(10)
        @past_assignments = Assignment.past.by_employee.by_store.paginate(page: params[:past_page]).per_page(10)  
      elsif current_user.employee.role == "manager"
        @current_assignments = Assignment.current.by_employee.chronological.for_store(current_user.employee.current_assignment.store.id).paginate(page: params[:current_page]).per_page(10)
      else
        @current_assignments = Assignment.for_employee(current_user.employee.id).current.by_store.by_employee.chronological.paginate(page: params[:current_page]).per_page(10)
        @past_assignments = Assignment.for_employee(current_user.employee.id).past.by_employee.by_store.paginate(page: params[:past_page]).per_page(10)  
      end
    end
  end

  def show
    # get the shift history for this assignment (later; empty now)
    @shifts = @assignment.shifts.chronological.paginate(page: params[:page]).per_page(5)
  end

  def new
    @assignment = Assignment.new
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
    @assignment = Assignment.new(assignment_params)
    
    if @assignment.save
      # redirect_to assignments_path, notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
      redirect_to assignment_path(@assignment), notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to assignments_path, notice: "#{@assignment.employee.proper_name}'s assignment to #{@assignment.store.name} is updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path, notice: "Successfully removed #{@assignment.employee.proper_name} from #{@assignment.store.name}."
  end

  private
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:employee_id, :store_id, :start_date, :end_date, :pay_level)
  end

end