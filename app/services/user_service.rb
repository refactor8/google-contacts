class UserService
  class << self
    def create(auth)
      @user = User.from_omniauth(auth)
      @user ||= User::NotLogged
    end
  end
end
