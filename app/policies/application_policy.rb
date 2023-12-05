# frozen_string_literal: true
# Given that the first argument is a user, in your controller,
#  Pundit will call the current_user method we defined in in ApplicationController,
#   to get what to send into this argument.
#  The second argument is the model object, whose authorization you want to check
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?                                                                   
    false
  end

  def create?
    false
  end

  # Same as for create 
  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
