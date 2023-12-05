class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  
  attr_reader :user,:records

  def initialize(user,records)
    @user = user
    @records = records
  end

  def index?
    user.superadmin?
  end

  def show?
    user.superadmin? || (records == user)
  end
end
