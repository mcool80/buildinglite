class AssignmentUpdatePolicy < ApplicationPolicy

  def index?
    user.admin?(:community => $current_community)
  end

  def update?
    user.admin?(:community => record.assignment.community)
  end

  def edit?
    user.admin?(:community => record.assignment.community)
  end

  def new?
    user.admin?(:community => $current_community)
  end

  def show?
    user.admin?(:community => record.assignment.community)
  end

  def destroy?
    user.admin?(:community => record.assignment.community)
  end

  def create?
    user.admin?(:community => record.assignment.community)
  end
end

