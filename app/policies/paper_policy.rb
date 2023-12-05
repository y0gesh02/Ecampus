class PaperPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.superadmin?
        scope.all
      elsif user.admin?
        scope.where(user: user)
      else
        scope.none
      end
    end
  end

  attr_reader :user, :paper

  def initialize(user, paper)
    @user = user
    @paper = paper
  end

  def index?
    user.superadmin? || user.admin?
  end

  def show?
    user.superadmin? || (user.admin? && paper.user == user)
  end

  def new?
    create?
  end

  def edit?
    user.superadmin? || (user.admin? && paper.user == user)
  end

  def update?
    user.superadmin? || (user.admin? && paper.user == user)
  end

  def create?
    user.admin? || user.superadmin?
  end

  def destroy?
    user.superadmin? || (user.admin? && paper.user == user)
  end
end
