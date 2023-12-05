class QuestionController < ApplicationController
  before_action :authenticate_user! 

  def index
    if params[:my_questions]
      @questions = current_user.questions
    else
      @questions = Question.all
    end
    authorize @questions
  end

  def new
    @question = Question.new
    authorize @question
  end

  def show
    @question = Question.find(params[:id])
    authorize @question
  end

  def create
    @question = Question.new(question_params)
    authorize @question
    @question.user = current_user
    
    if @question.save
      redirect_to question_index_path, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    authorize @question
    @editing = true
  end

  def update
    @question = Question.find(params[:id])
    authorize @question

    if @question.update(question_params)
      redirect_to question_path, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    authorize @question
    @question.destroy

    redirect_to question_index_path, notice: 'Question was successfully deleted.'
  end

  
  private

  def question_params
    params.require(:question).permit(:question, :correct_answer,:answer, :question_type, options: [])
  end
end
