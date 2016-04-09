class ApartmentPolicy < ApplicationPolicy

  def update?
    user.admin?(:community => record.community)
  end

  def index?
    user.admin?
  end

  def showinfo?
    user.apartment.id == record.id || user.admin?(record.community)
  end

  def edit?
    user.admin?(:apartment => record)
  end

  def new?
    user.admin?(:community => $current_community)
  end

  def show?
    user.admin?(:apartment => record)
  end

  def destroy?
    user.admin?(:apartment => record)
  end

  def create?
    user.admin?(:apartment => record)
  end

  # controller moves
  def select_apartment?
    user.admin?(:apartment => record)
  end
  def change_users?
    user.admin?(:apartment => record)
  end
end

