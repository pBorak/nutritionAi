class ProfilePolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def show?
    user.profile == resource
  end

  alias update? show?
end
