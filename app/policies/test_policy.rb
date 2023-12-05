class TestPolicy < ApplicationPolicy
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
  attr_reader :user, :test

  def initialize(user, test)
    @user = user
    @test = test
  end

  def index?
    user.superadmin? || user.admin?
  end

  def show?
    user.superadmin? || (user.admin? && test.user == user)
  end

  # Same as for create 
  def new?
    create?
  end

  # Same as that of the update.
  def edit?
    user.superadmin? || (user.admin? && test.user == user)
  end

  # Only admin is allowed to update the article and only if article is not published
  def update?
    user.superadmin? || (user.admin? && test.user == user)
  end

  # Only admin is allowed to create the article.
  def create?
    user.admin? || user.superadmin?
  end

  def destroy?
    user.superadmin? || (user.admin? && test.user == user)
  end
end

