# Null Object Pattern
class User::NotLogged
  attr_reader :name, :email, :image

  def initialize
    @name = nil
    @email = nil
    @image = nil
  end

  def self.persisted?
    false
  end

  def self.errors
    false
  end
end
