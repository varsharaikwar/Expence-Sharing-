class GroupsController < ApplicationController

  def edit
    @group = Group.find(params[:id])
    @invite = @group.invites.new()
  end
end
