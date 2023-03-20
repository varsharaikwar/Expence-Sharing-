class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    return redirect_to user_groups_path(current_user) if current_user
  end

  def show
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    @ious = @user.owed(@group).select{|iou| iou.nil? == false}
    @debts = @user.debts.nil? ? nil : @user.debts.select{|debt| debt.expense.group == @group && debt.reconciled == false}
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

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
