class JobsController < ApplicationController
  before_action :set_job, only: [:show,:edit, :update, :destroy]
  before_action :check_login

  def index
    
  end

  def show
    # get the shift history for this assignment (later; empty now)
    # @shifts = Array.new
  end

  def new
    @job = Job.new
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
    if @job.update(job_params)
      redirect_to jobs_path, notice: "#{@job.name} job is updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: "Successfully removed #{@job.name} from system."
  end

  private
  def set_flavor
    @job = Job.find(params[:id])
  end

  def flavor_params
    params.require(:job).permit(:name, :description, :active)
  end

end