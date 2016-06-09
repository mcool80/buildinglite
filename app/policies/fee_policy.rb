class FeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if not $current_community.nil? then
        scope.where(:community => $current_community.id)
      else
        scope = []
      end
    end
  end

  def index?
    not user.nil?
  end

  def new?
    user.admin?
  end

  def show?
    user.admin?(:community => record.community)
  end

  def edit?
    user.admin?(:community => record.community)
  end

  def update?
    user.admin?(:community => record.community)
  end

  def create?
    user.admin?(:community => record.community)
  end

  def destroy?
    user.admin?(:community => record.community)
  end

  # fee_page
  def administrate?
    user.admin?(:community => record.community)
  end

  def add_fee_transaction?
    user.admin?(:community => record.community)
  end

  def check_fee?
    user.admin?(:community => record.community)
  end

  def fee_report?
    user.admin?(:community => record.community)
  end

  def save_result?
    user.admin?(:community => record.community)
  end
end
