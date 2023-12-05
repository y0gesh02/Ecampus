class JobApplicationsController < ApplicationController
  before_action :authenticate_user! 
  before_action :find_job

  def index
    authorize @job, policy_class: JobApplicationsPolicy
    @job_applications = @job.job_applications
  end

  def new
    authorize @job, policy_class: JobApplicationsPolicy
    @job_application = @job.job_applications.new
  end

  def create
    authorize @job, policy_class: JobApplicationsPolicy
    @job_application = @job.job_applications.new(job_application_params)
    @job_application.user = current_user
    
    if @job_application.save
      redirect_to job_path(@job), notice: "Application submitted successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @job, policy_class: JobApplicationsPolicy
    @job_application = @job.job_applications.find(params[:id])

    if @job_application.update(job_application_params)
          render json: { status: @job_application.status } 
    else
      render :index, status: :unprocessable_entity
    end
  end
  private

  def find_job
    @job = Job.find(params[:job_id])
  end

  def job_application_params
    params.require(:job_application).permit(:contact_information,:status)
  end
end
