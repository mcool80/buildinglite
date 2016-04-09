class UserPolicy < ApplicationPolicy
  attr_reader :user, :user_obj

  def initialize(user, user_obj)
    @user = user
    @user_obj = user_obj
  end

  def index?
    user.admin?
  end

  def show?
    user.admin?(:community => user_obj.apartment.community) || user.id == user_obj.id
  end

  def connect?
    user.admin?(:community => user_obj.apartment.community)
  end

  def edit?
    user.admin?(:community => user_obj.apartment.community) || user.id == user_obj.id
  end

  def update?
    user.admin?(:community => user_obj.apartment.community) || user.id == user_obj.id
  end

  def destroy?
    user.id == user_obj.id
  end
end

