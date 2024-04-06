class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def index 
    # Get all passwords
    # @passwords = 
  end
end