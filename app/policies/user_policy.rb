class UserPolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def show?
    user == resource
  end

  alias update? show?
end
