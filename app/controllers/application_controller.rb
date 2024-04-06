class ApplicationController < ActionController::Base
  def current_user_password
    # ||= is the "or equals" operator. It assigns a value to the variable on its left if and only if that variable is either nil or not yet defined. 
    @_current_user_password ||= current_user.user_passwords.find_by(password: @password)
  end

  helper_method :current_user_password 
end
