class CampusDrivesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_campus_drive, only: %i[show edit update destroy ]

  def index
    if params[:my_campus_drives]
      @campus_drives = current_user.campus_drives
    else
      @campus_drives = CampusDrive.all
      respond_to do |format|
        format.html { render :index }

      format.json { render json: @campus_drives }
      format.xml { render xml: @campus_drives }

      end

    end
  end

  def show
  end

  def new
    @campus_drive = CampusDrive.new
    authorize @campus_drive 
  end

  def edit
    authorize @campus_drive 
  end

  def create
    @campus_drive = CampusDrive.new(campus_drive_params)
    authorize @campus_drive
    @campus_drive.user = current_user
    selected_test_id = params[:campus_drive][:test_id]

    respond_to do |format|
      if @campus_drive.save
        format.html { redirect_to campus_drife_path(@campus_drive), notice: "Campus drive was successfully created." }
        format.json { render :show, status: :created, location: @campus_drive }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campus_drive.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @campus_drive

    respond_to do |format|
      if @campus_drive.update(campus_drive_params)
        format.html { redirect_to campus_drife_path(@campus_drive), notice: "Campus drive was successfully updated." }
        format.json { render :show, status: :ok, location: @campus_drive }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campus_drive.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @campus_drive
    @campus_drive.destroy
    
    respond_to do |format|
      format.html { redirect_to campus_drives_path, notice: "Campus drive was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  

  private

  def set_campus_drive
    @campus_drive = CampusDrive.find(params[:id])
  end

  def campus_drive_params
    params.require(:campus_drive).permit(:name, :location, :description, :start_date, :end_date, :test_id ,:eligible_year)
  end
end

