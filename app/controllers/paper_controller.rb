class PaperController < ApplicationController
  before_action :authenticate_user! 

  def index
    @papers = policy_scope(Paper)
    authorize Paper
  end

  def new
    @paper = Paper.new
    authorize @paper
  end

  def show
    @paper = Paper.find(params[:id])
    authorize @paper
  end

  def create
    @paper = Paper.new(paper_params)
    authorize @paper
    selected_question_ids = params[:paper][:question_ids]
    @paper.user = current_user

    if @paper.save
      redirect_to user_paper_index_path, notice: 'Paper created successfully.'
    else
      render :new
    end
  end

  def edit
    @paper = Paper.find(params[:id])
    authorize @paper
  end

  def update
    @paper = Paper.find(params[:id])
    authorize @paper

    if @paper.update(paper_params)
      redirect_to user_paper_path, notice: 'Paper was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @paper = Paper.find(params[:id])
    authorize @paper
    @paper.destroy
    redirect_to user_paper_index_path, notice: 'Paper was successfully deleted.'
  end

  
  private

  def paper_params
    params.require(:paper).permit(:name, :description, :total_marks, :duration_in_minutes,:passing_marks,question_ids: [])
  end
end
