class UserPolicy
  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def ban?
    ["admin", "moderator"].include? @user.role
  end
end
