module UsersHelper
  def my_user?(user)
    user == current_user
  end
end
