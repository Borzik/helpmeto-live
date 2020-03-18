class AuthPolicy < ApplicationPolicy
  def create?
    !@user
  end

  def activate?
    !@user
  end
end