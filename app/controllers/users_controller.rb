class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    @bills = Bill.find_all_by_user(@user)
    @debts = Bill.debts_for_user(@user).collect { |uid, debt| [User.find(uid), debt] }
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

end
