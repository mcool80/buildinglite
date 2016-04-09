class FeeTransactionPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?(:community => $current_community) or $current_apartment == user.apartment then
        if $current_apartment.moved.nil? then
          scope.where(apartment_id: $current_apartment.id)
        else
          scope.where(apartment_id: $current_apartment.id).where('start_date >= ?' ,$current_apartment.moved)
        end
      else
        scope = []
      end
    end
  end

  def index?
    user.admin?(:community => $current_community) or $current_apartment == user.apartment
  end

  def create?
    user.admin?(:apartment => record.apartment) or ( user.apartment == record.apartment and record.transaction_type == 'input' )
  end

  def update?
    user.admin?(:apartment => record.apartment) 
  end

  def new?
    user.admin?(:apartment => record.apartment) or user.apartment == record.apartment
  end

  def destroy?
    user.admin?(:apartment => record.apartment) or (user.apartment == record.apartment and record.transaction_type == 'input' )
  end

  def edit?
    user.admin?(:apartment => record.apartment) or user.apartment.id == record.apartment.id
  end
  
  def show?
    user.admin?(:apartment => record.apartment) or (user.apartment == record.apartment)
  end
    
end
