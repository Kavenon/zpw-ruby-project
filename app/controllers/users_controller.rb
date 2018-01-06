class UsersController < ApplicationController
  before_action :check_if_logged, only: [:show, :edit, :update]

  # GET /users/new
  def new
    @user = User.new
    render :layout => 'auth'
  end

  # GET /users/profile
  def profile
    @user = current_user;
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    render :layout => 'auth'
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user

        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, :layout => 'auth' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    if params[:password].blank?
      params.delete(:password)
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, :layout => 'auth' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :birthday)
    end
end
