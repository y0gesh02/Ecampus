class JobController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_job, only: %i[show edit update destroy ]

  def index
    if params[:my_jobs]
      @jobs = current_user.jobs
    else
      @jobs = Job.all
    end 
  end

  def show
  end

  def new
    @job = Job.new
    authorize @job 
  end

  def edit
    authorize @job 
  end

  def create
    @job = Job.new(job_params)
    authorize @job 
    @job.user = current_user

    respond_to do |format|
      if @job.save
        format.html { redirect_to job_path(@job), notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @job 

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_path(@job), notice: "Campus drive was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @job 
    @job.destroy
    
    respond_to do |format|
      format.html { redirect_to job_index_path, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :company_name, :description, :status, :contact_info,:salary ,:test_id)
  end
end
