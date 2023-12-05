class TestAttemptPolicy < ApplicationPolicy
  class Scope < Scope
  end

  attr_reader :user, :test_attempt

  def initialize(user, test_attempt)
    @user = user
    @test_attempt = test_attempt
  end

  def index?
    user.superadmin? || (user.admin? && test_attempts_belongs_to_admin?)
  end

  def show?
    user_can_access_test_attempt? 
  end

  def new?
    true
  end

  def create?
    user_registered_for_drive?
  end

  def submit_paper?
    user_can_access_test_attempt?
  end

  private

  def user_can_access_test_attempt?
    user == test_attempt.user && test_attempt.submitted_at.nil?
  end
  
  def test_attempts_belongs_to_admin?
    if test_attempt.present?
      user.admin? && test_attempt.first.campus_drive.user == user 
    end
  end

  def user_registered_for_drive?
    test_attempt.campus_drive.campus_applications.where(user_id: user.id).exists?
  end
end
