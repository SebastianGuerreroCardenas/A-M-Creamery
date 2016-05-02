class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @active_users = User.active.paginate(page: params[:active_page]).per_page(10)
    @inactive_users = User.inactive.paginate(page: params[:inactive_page]).per_page(10)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "User {@user.employee.name} was created."
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "#User {@user.employee.name} was updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user && current_user.role?(:admin)
        params.require(:user).permit(:email, :password, :password_confirmation, :employee_id)  
      else
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
end