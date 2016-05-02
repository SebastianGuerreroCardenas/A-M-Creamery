class JobsController < ApplicationController
  before_action :set_job, only: [:show,:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @active_jobs = Job.active.alphabetical.paginate(page: params[:active_page]).per_page(10)
    @inactive_jobs = Job.inactive.alphabetical.paginate(page: params[:inactive_page]).per_page(10)
  end

  def show
    
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    
    if @job.save
      redirect_to job_path(@job), notice: "Successfully created #{@job.name}."
    else
      render action: 'new'
    end
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
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:name, :description, :active)
  end

end