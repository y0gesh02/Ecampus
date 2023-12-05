class CampusDriveApplicationsController < ApplicationController
  before_action :authenticate_user! 
  before_action :find_campus_drive

  def index
    authorize @campus_drive, policy_class: CampusDriveApplicationPolicy
    @campus_application = @campus_drive.campus_applications
  end

  def new
    authorize @campus_drive, policy_class: CampusDriveApplicationPolicy
    @campus_application = @campus_drive.campus_applications.new
  end

  def create
    authorize @campus_drive, policy_class: CampusDriveApplicationPolicy
    @campus_application = @campus_drive.campus_applications.new(campus_application_params)
    @campus_application.user = current_user

    if @campus_application.save
      redirect_to campus_drife_path(@campus_drive), notice: "Application submitted successfully."
    else
      render :new
    end
  end

  def update
    authorize @campus_drive, policy_class: CampusDriveApplicationPolicy
    @campus_application = @campus_drive.campus_applications.find(params[:id])

    if @campus_application.update(campus_application_update_params)
          render json: { status: @campus_application.status } 
    else
      render :index, status: :unprocessable_entity
    end
  end
  

  private

  def find_campus_drive
    @campus_drive = CampusDrive.find(params[:campus_drife_id])
  end

  def campus_application_params
    params.require(:campus_application).permit(:contact_information)
  end

  def campus_application_update_params
    params.require(:campus_application).permit(:status)
  end
end
