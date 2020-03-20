class NeedPolicy < ApplicationPolicy
  def index?
    @user && @user.volunteer?
  end

  def show?
    @user
  end

  def edit?
    @user.recipient? && @user.id == @record.user_id
  end

  def update?
    @user.recipient? && @user.id == @record.user_id
  end

  def destroy?
    @user.recipient? && @user.id == @record.user_id
  end

  class Scope < Scope
    def resolve
      scope.within_10km_from(@user.location.to_s)
    end
  end
end