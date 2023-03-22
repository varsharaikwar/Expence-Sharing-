class InvitationMailer < ApplicationMailer
  default from: "thetimfoley@gmail.com"

  def new_user_invite(invite, group, user, path)
    @invite = invite
    @path = path
    @group = group
    @user = user
    mail(to: @invite.email, from:  "thetimfoley@gmail.com", subject: 'Welcome to Expensiv!')
  end

end
