class OfferPolicy < ApplicationPolicy
  def create?
    @user.volunteer? && @user.id == @record.user_id
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: @user.id)
    end
  end
end
