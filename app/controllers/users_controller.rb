class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      
    end
end