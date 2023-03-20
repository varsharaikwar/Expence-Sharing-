class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.new()
    @user = current_user
  end

  def create
    @group = Group.create(group_params)
    @group.memberships.create(user: current_user)

    redirect_to group_user_path(@group, current_user)
  end

  def edit
    @group = Group.find(params[:id])
    @invite = @group.invites.new()
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
