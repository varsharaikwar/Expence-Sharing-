class Invite < ApplicationRecord
  belongs_to :group
  belongs_to :sender, class_name: :user
  belongs_to :recipient, class_name: :user

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.group_id, Time.now, rand].join)
  end
end
