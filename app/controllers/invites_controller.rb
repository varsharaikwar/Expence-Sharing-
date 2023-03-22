class InvitesController < ApplicationController

  def create
    @group = Group.find(params[:invite][:group_id])
    @invite = Invite.new(invite_params) 
    @invite.sender_id = current_user.id 
    if @invite.save
      if @invite.recipient_id != nil
        @recipient = User.find(@invite.recipient_id)
        @recipient.memberships.create!(group_id: @invite.group_id)

      else
        InvitationMailer.new_user_invite(@invite, @group, current_user, new_user_registration_url(invite_token: @invite.token)).deliver
      end
      redirect_to group_user_path(@group, current_user)
    else
     
    end
  end

  private
  def invite_params
    params.require(:invite).permit(:email, :group_id, :sender_id, :recipient_id, :token)
  end

end


