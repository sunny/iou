class UsersController < ApplicationController
  before_filter :verify_access, :except => [:index, :new]

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @bills = @user.bills
    @debts = @user.debts
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.create(params[:user])
    if @user.errors.empty?
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_path
  end
end
