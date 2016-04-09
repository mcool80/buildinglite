class CommunityPolicy < ApplicationPolicy

  def update?
    user.admin?(:community => record)
  end

  def index?
    user.super_admin?()
  end

  def edit?
    user.admin?(:community => record)
  end

  def new?
    user.super_admin?()
  end

  def show?
    user.admin?(:community => record)
  end

  def destroy?
    user.super_admin?()
  end

  def create?
    user.super_admin?()
  end
end

