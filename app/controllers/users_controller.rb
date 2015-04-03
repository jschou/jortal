class UsersController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :check_user!
  before_filter :check_admin!, except: [:index, :show]
  respond_to :html, :json

  # GET /users
  def index
    @users = User.all
    @who = session[:cas_user]

    respond_with @users
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  # GET /users/new
  def new
    @user = User.new

    respond_with @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    flash[:notice] = 'User was successfully created.' if @user.save
    respond_with @user
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
    end
    respond_with @user
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with @user
  end
end
