class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :expenses
  has_many :debts, foreign_key: "debtor_id"

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :invitations, class_name: :invite, foreign_key: :recipient_id
  has_many :sent_invites, class_name: :invite, foreign_key: :sender_id

  def owed(group)
    self_expenses = group.expenses.select {|expense| expense.user == self}
    group_ious = self_expenses.map do |expense|
      expense.debts
    end

    return group_ious.flatten
  end

  def balance(group, user = nil)
    # puts "BALANCING"
    if user.nil? == false # if you pass in a specific user

      # get total amount owed to me by user
      positive_balance = 0

      they_owe = self.owed(group).select do |debt|
        debt.debtor == user
      end
      they_owe.each do |debt|
        positive_balance += debt.amount
      end

      # get total amount owed to user by me
      negative_balance = 0

      self_owes = user.owed(group).select do |debt|
        debt.debtor === self
      end

      self_owes.each do |debt|
        negative_balance -= debt.amount
      end
      # add together
      total_balance = positive_balance + negative_balance

      # return user.id and an amount (decide what positive/negative numbers mean)
      return {user_id: user.id, balance: total_balance.to_f}
    else
      # run this same method, but iterate through all users
      other_users = User.all.select{|user| !(user == self)}
      other_users.map do |user|
        self.balance(group, user)
      end
    end

  end
end
