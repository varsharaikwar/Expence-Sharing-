class InvitationMailer < ApplicationMailer
  default from: "thetimfoley@gmail.com"

  def new_user_invite(invite, path)
    @invite = invite
    mg_client = Mailgun::Client.new ENV['mailgun_sandbox']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @invite.email,
                      :subject => 'Welcome to Expensiv!',
                      :text    => "Use this link to log in: #{path}"}
    mg_client.send_message ENV['domain'], message_params
  end

end
