class InvitesController < ApplicationController

  def create

    @invite = Invite.new(invite_params) #make a new invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save
      InvitationMailer.new_user_invite(@invite, new_user_registration_url(invite_token: @invite.token)).deliver
    else
      # invitation creation failed!
    end
  end

  private
  def invite_params
    params.require(:invite).permit(:email, :group_id, :sender_id, :recipient_id, :token)
  end

end
