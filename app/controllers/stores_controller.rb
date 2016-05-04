class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy, :edit_store_flavor]
  before_action :check_login, except: [:index, :show]
  authorize_resource

  def index
    @active_stores = Store.active.alphabetical.paginate(page: params[:active_page]).per_page(10)
    @inactive_stores = Store.inactive.alphabetical.paginate(page: params[:inactive_page]).per_page(10)  
  end

  def show
    @store.get_store_coordinates
    @current_assignments = @store.assignments.current.by_employee.paginate(page: params[:page]).per_page(8)
    @flavors = @store.flavors
  end

  def new
    @store = Store.new
  end

  def edit
    respond_to do |format|
      format.js 
      format.html {}
    end
  end

  def edit_store_flavor
    respond_to do |format|
      format.js 
    end
  end

  def create
    @store = Store.new(store_params)
    respond_to do |format|
      if @store.save
        format.js
        redirect_to store_path(@store), notice: "Successfully created #{@store.name}."
      else
        render action: 'new'
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.js
        format.html {redirect_to store_path(@store), notice: "Successfully updated #{@store.name}."}
      else
        format.html { render action: 'edit'}
      end
    end
  end

  def destroy
    @store.destroy
    redirect_to stores_path, notice: "Successfully removed #{@store.name} from the AMC system."
  end

  private
  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    if current_user && current_user.role?(:admin)
      params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active, :flavor_ids => [])
    else
       params.require(:store).permit(:flavor_ids => [])
    end
  end

end