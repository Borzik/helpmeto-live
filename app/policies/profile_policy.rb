class ProfilePolicy < ApplicationPolicy
  def edit?
    @user && @user.guest?
  end
  def edit_recipient?
    @user && (@user.guest? || @user.recipient?)
  end
  def edit_volunteer?
    @user && (@user.guest? || @user.volunteer?)
  end
  def update?
    @user && (@user.volunteer? || @user.recipient?)
  end
end
