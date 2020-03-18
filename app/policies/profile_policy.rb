class ProfilePolicy < ApplicationPolicy
  def edit?
    @user
  end
  def edit_recipient?
    @user
  end
  def edit_volunteer?
    @user
  end
  def update?
    @user
  end
end
