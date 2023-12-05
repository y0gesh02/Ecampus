class TestAttemptController < ApplicationController
  before_action :authenticate_user!
  before_action :check_attempt, only: %i[create]
  before_action :set_value , only: %i[show submit_paper]

  def index
    @campus_drive = CampusDrive.find(params[:campus_drife_id])
    @test_attempts = @campus_drive.test_attempts
    authorize @test_attempts
    @campus_application = @campus_drive.campus_applications
  end

  def new
    @campus_drive = CampusDrive.find(params[:campus_drife_id])
    @test = @campus_drive.test
    remaining_time_seconds = (@campus_drive.end_date - DateTime.now.utc).to_i
    @remaining_time_in_seconds = remaining_time_seconds
  end
  
  def create
    if @previous_attempt
      flash[:notice] = "Resuming your previous attempt..."
      @test_attempt = @previous_attempt
      @current_paper, @current_paper_index = find_current_paper(@previous_attempt)
      redirect_to campus_drife_test_attempt_path(@campus_drive, @test_attempt, paper_index: @current_paper_index)
      return
    end
    @test_attempt = TestAttempt.new(user: current_user, test: @test, started_at: Time.now,campus_drive_id: @campus_drive.id)  
    authorize @test_attempt
    if @test_attempt.save!
      redirect_to campus_drife_test_attempt_path(@campus_drive, @test_attempt,paper_index: 0)
    else
      flash[:error] = 'Failed to start the test attempt.'
      redirect_to @campus_drive
    end
  end

  def show
    authorize @test_attempt
    @papers = @test_attempt.test.papers
    @current_paper_index = params[:paper_index].to_i
    @current_paper = @papers[@current_paper_index]
    @questions = @current_paper.questions  
  end

  def submit_paper
    authorize @test_attempt
    @current_paper_index = params[:paper_index].to_i
    @papers = @test_attempt.test.papers 
    @current_paper = @papers[@current_paper_index]
    questions = @current_paper.questions
    success = true
  
    questions.each do |question|
      response_choice = params["question_#{question.id}"]
      response_text = params["answer_#{question.id}"]
  
      @report = Report.new(
        user_id: current_user.id,
        question_id: question.id,
        paper_id: @current_paper.id,
        response_choice: response_choice,
        response_text: response_text,
        test_attempt_id: @test_attempt.id
      )
      unless @report.save
        flash[:alert] = 'There was an issue with your response.'
        success = false
        break  
      end
    end

    if success
      next_paper_path(@papers)
    else
      flash[:now] = 'There was an issue with your response.'
      render :show
    end
  end

  def success
  end
  

  private
  
  def find_current_paper(test_attempt)
    latest_report = test_attempt.reports.order(created_at: :desc).first
    if latest_report.present?
      current_paper = latest_report.paper
      paper_index = test_attempt.test.papers.index(current_paper)
      [current_paper, paper_index + 1]
    else
      first_paper = test_attempt.test.papers.first
      [first_paper, 0]
    end
  end

  def set_value
    @campus_drive = CampusDrive.find(params[:campus_drife_id])
    @test_attempt = TestAttempt.find(params[:id])
    @test_attempts = @campus_drive.test_attempts
  end

  def check_attempt
    @campus_drive = CampusDrive.find(params[:campus_drife_id])
    @test = @campus_drive.test
    @previous_attempt = @campus_drive.test_attempts.find_by(user_id: current_user.id)
    current_time_utc = Time.now.utc
    if @previous_attempt && @previous_attempt.submitted_at.present?
      redirect_to @campus_drive, alert: 'You have already completed this test.'
    elsif current_time_utc > @campus_drive.end_date
      redirect_to @campus_drive, alert: 'The test has ended. You cannot start a new attempt.'
    elsif current_time_utc < @campus_drive.start_date
      redirect_to @campus_drive, alert: 'The test has not started yet. You cannot start the test.'
    end
  end

  def next_paper_path(papers)
    next_index = @current_paper_index + 1
    if next_index < papers.size
      redirect_to campus_drife_test_attempt_path(@campus_drive, @test_attempt, paper_index: next_index)
    else
      @test_attempt.total_score = calculated_user_score(@test_attempt)
      @test_attempt.submitted_at = Time.now
      @test_attempt.set_status_job(current_user, @campus_drive)
      @test_attempt.save!
      redirect_to success_path
    end
  end

  def calculated_user_score(test_attempt)
    total_score = 0
    test_attempt.reports.each do |report|
      question = Question.find(report.question_id)
      if question.question_type == 'objective'
        if report.response_choice == question.correct_answer
          total_score += 1  
        end
      elsif question.question_type == 'answer'
        if report.response_text.present? && report.response_text == question.answer
          total_score += 1  
        end
      end
    end
    total_score
  end
end
