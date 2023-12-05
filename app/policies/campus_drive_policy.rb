class CampusDrivePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :campus_drive

  def initialize(user, campus_drive)
    @user = user
    @campus_drive = campus_drive
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
    user.superadmin? || (user.admin? && campus_drive.user == user)
  end

  def update?
    user.superadmin? || (user.admin? && campus_drive.user == user)
  end

  def create?
    user.admin? || user.superadmin?
  end

  def destroy?
    user.superadmin? || (user.admin? && campus_drive.user == user)
  end
end
