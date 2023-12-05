class JobPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :job

  def initialize(user, job)
    @user = user
    @job = job
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.admin? || user.superadmin?
  end

  def edit?
    user.superadmin? || (user.admin? && job.user == user)
  end

  def update?
    user.superadmin? || (user.admin? && job.user == user)
  end

  def create?
    user.admin? || user.superadmin?
  end

  def destroy?
    user.superadmin? || (user.admin? && job.user == user)
  end
end
