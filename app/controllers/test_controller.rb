class TestController < ApplicationController
  before_action :authenticate_user! 

  def index
    @tests = policy_scope(Test)
    authorize Test
  end

  def new
    @test = Test.new
    authorize @test
  end

  def show
    @test = Test.find(params[:id])
    authorize @test
  end

  def create
    @test = Test.new(test_params)
    authorize @test
    # Build associations with selected papers
    selected_paper_ids = params[:test][:paper_ids]
    @test.user = current_user
    if @test.save
      redirect_to user_test_index_path, notice: 'Test was created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @test = Test.find(params[:id])
    authorize @test
  end

  def update
    @test = Test.find(params[:id])
    authorize @test

    if @test.update(test_params)
      redirect_to user_test_path, notice: 'Test was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @test = Test.find_by(id: params[:id])
    authorize @test
    if @test
      @test.destroy
      redirect_to user_test_index_path, notice: 'Test was successfully deleted.'
    else
      redirect_to user_test_index_path, alert: 'Test not found or already deleted.'
    end
  end


  private

  def test_params
    params.require(:test).permit(:name, :details, paper_ids: [])
  end
end
