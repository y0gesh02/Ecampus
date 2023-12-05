class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :question

  def initialize(user, question)
    @user = user
    @question = question
  end

  def index?
    user.admin? || user.superadmin?
  end

  def show?
    user.admin? || user.superadmin?
  end

  def new?
    user.admin? || user.superadmin?
  end

  def edit?
    user.superadmin? || (user.admin? && question.user == user)
  end

  def update?
    user.superadmin? || (user.admin? && question.user == user)
  end

  def create?
    user.admin? || user.superadmin?
  end

  def destroy?
    user.superadmin? || (user.admin? && question.user == user)
  end
end
