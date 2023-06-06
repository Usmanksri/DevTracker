module UserHelper
  def create_user(role)
    User.create(
      name: 'name',
      email: 'email@gmail.com',
      password: 'password',
      role: role
    )
  end
end
