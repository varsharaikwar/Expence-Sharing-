class Invite < ApplicationRecord
  belongs_to :group
  belongs_to :sender, class_name: :user
  belongs_to :recipient, class_name: :user

  before_create :generate_token
  before_save :check_user_existence

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.group_id, Time.now, rand].join)
  end
end
