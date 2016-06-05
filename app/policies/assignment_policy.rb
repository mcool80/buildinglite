class AssignmentPolicy < ApplicationPolicy

  def update?
    user.admin?(:community => record.community)
  end

  def index?
    user.admin?(:community => $current_community)
  end

  def edit?
    user.admin?(:community => record.community)
  end

  def new?
    user.admin?(:community => record.community)
  end

  def show?
    user.admin?(:community => record.community)
  end

  def destroy?
    user.admin?(:community => record.community)
  end

  def create?
    user.admin?(:community => record.community)
  end

  def close?
    user.admin?(:community => record.community)
  end

  def closed_list?
    user.admin?(:community => $current_community)
  end

  def latest_updates?
    user.admin?(:community => $current_community)
  end

  def show_assignments?
    user.admin?(:community => $current_community)
  end
end

