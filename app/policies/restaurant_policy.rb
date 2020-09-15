class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    # The owner of the restaurant
    record.user == user
  end

  def create?
    # Anyone who is a user
    !user.nil?
  end

  def destroy?
    # The owner of the restaurant should be able to delete
    update?
  end
end

