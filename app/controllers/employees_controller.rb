class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource
  
  def index
    if logged_in?
      if current_user.employee.role == "admin"
        @active_employees = Employee.active.alphabetical.paginate(page: params[:active_page]).per_page(10)
        @inactive_employees = Employee.inactive.alphabetical.paginate(page: params[:inactive_page]).per_page(10)
      elsif current_user.employee.role == "manager"
        @active_employees = Employee.active.alphabetical.for_store(current_user.employee.current_assignment.store.id).paginate(page: params[:active_page]).per_page(10)
      else
         
      end
    end
  end

  def show
    @assignments = @employee.assignments.chronological.paginate(page: params[:page]).per_page(5)
  end

  def new
    @employee = Employee.new
    user = @employee.build_user
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employee_path(@employee), notice: "Successfully created #{@employee.proper_name}."
    else
      render action: 'new'
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to employee_path(@employee), notice: "Successfully updated #{@employee.proper_name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, notice: "Successfully removed #{@employee.proper_name} from the AMC system."
  end

  private
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :role, :phone, :active,user_attributes: [:id, :email, :password, :password_confirmation, :_destroy])
  end

end