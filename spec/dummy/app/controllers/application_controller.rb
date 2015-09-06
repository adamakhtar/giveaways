class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def giveaways_user
  	User.first
  end

  def giveaways_unauthorized_path
  	'/' # user_sign_in_path
  end
end
