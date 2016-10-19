# Preview all emails at http://localhost:3000/rails/mailers/example_mailer
class ExampleMailerPreview < ActionMailer::Preview
  def sample_email_preview
    ExampleMailer.sample_email(User.first)
  end
end
