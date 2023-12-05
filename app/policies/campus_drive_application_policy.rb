class CampusDriveApplicationPolicy  < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user,:campus_drive

  def initialize(user,campus_drive)
    @user = user
    @campus_drive = campus_drive
  end

  def index?
    user.superadmin? || user.admin? && campus_applications_belongs_to_admin?
  end

  def new?
    check_eligiblity?
  end

  def update?
    index?
  end

  def create?
    new?
  end

  def campus_applications_belongs_to_admin?
    user.admin? && user.campus_drives.include?(campus_drive)
  end

  def check_eligiblity?
    user.course_year == campus_drive.eligible_year
  end
end
