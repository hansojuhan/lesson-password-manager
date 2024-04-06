class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_password, except: [ :index, :new, :create ]
  before_action :require_editable_permission, only: [ :edit, :update, :destroy ]
  before_action :require_deletable_permission, only: [ :destroy ]

  def index 
    # Get all passwords
    @passwords = current_user.passwords # This joins the 2 tables and gives user passwords
  end

  def new
    @password = Password.new
  end

  def create
    # This worked before adding roles
    # @password = current_user.passwords.create(password_params)
    # Defining a role as well
    @password = Password.new(password_params)
    @password.user_passwords.new(user: current_user, role: :owner)

    # if @password.persisted?
    if @password.save
      flash[:success] = "Password successfully created"
      redirect_to @password
    else
      flash[:error] = "Something went wrong"
      render 'new', status: :unprocessable_entity
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @password.update(password_params)
      redirect_to @password
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @password.destroy
    redirect_to root_path
  end

  private
  def password_params
    params.require(:password).permit(:url, :username, :password)
  end

  def set_password
    @password = current_user.passwords.find(params[:id])
    @user_password = current_user.user_passwords.find_by(password: @password)
  end

  def require_editable_permission
    redirect_to @password unless current_user_password.editable?
  end
  def require_deletable_permission
    redirect_to @password unless current_user_password.deletable?
  end
end