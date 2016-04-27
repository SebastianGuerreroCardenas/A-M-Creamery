class FlavorsController < ApplicationController
  before_action :set_flavor, only: [:show,:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    
  end

  def show
    # get the shift history for this assignment (later; empty now)
    # @shifts = Array.new
  end

  def new
    @flavor = Flavor.new
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
    if @flavor.update(flavor_params)
      redirect_to flavors_path, notice: "#{@flavor.name}'s shift to #{@flavor.store.name} is updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @flavor.destroy
    redirect_to flavors_path, notice: "Successfully removed #{@flavor.name} from #{@flavor.store.name}."
  end

  private
  def set_flavor
    @flavor = Flavor.find(params[:id])
  end

  def flavor_params
    params.require(:flavor).permit(:name, :active)
  end

end