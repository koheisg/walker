class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  delegate_missing_to :user

  def save
    user.authenticate(password)
  end

  def user
    @user ||= User.find_by(email: email)
  end
end
