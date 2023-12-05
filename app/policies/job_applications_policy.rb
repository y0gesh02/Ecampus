class JobApplicationsPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  attr_reader :user,:job

  def initialize(user,job)
    @user = user
    @job = job
  end

  def index?
    user.superadmin? || user.admin? && job_applications_belongs_to_admin?
  end

  def new?
    true
  end

  def update?
    user.superadmin? || user.admin? && job_applications_belongs_to_admin?
  end

  def create?
    true
  end

  def job_applications_belongs_to_admin?
    user.admin? && user.jobs.include?(job)
  end
end
