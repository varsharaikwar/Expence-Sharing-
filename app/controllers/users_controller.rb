class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    @ious = @user.owed(@group).nil? ? nil : @user.owed(@group)
    @debts = @user.debts.nil? ? nil : @user.debts.select{|debt| debt.expense.group == @group}
  end

  def groups
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    redirect_to user_path(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  # strong params
  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
