class ExampleMailer < ApplicationMailer
  default from: "thetimfoley@gmail.com"

  def sample_email(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['mailgun_sandbox']
    message_params = {:from   => ENV['gmail_username'],
                      :to     => @user.email,
                      :subject=> 'Sample Mailgun API email',
                      :text   => 'Yep #{@user.name}, this is a mailgun email.'}
    mg_client.send_message ENV['domain'], message_params
  end
end
