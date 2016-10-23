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

  validates :name, :email, presence: true

  def owed(group, user = nil)
    # select all the expenses that belong to self
    self_expenses = group.expenses.select{|expense| expense.user == self}
    group_ious = self_expenses.map{|expense| expense.debts}.flatten
    user.nil? ? owed_by_all(group_ious) : owed_by_user(group_ious, user)
  end

  def owed_by_all(group_ious)
    return group_ious.select{|debt| debt.reconciled == false}
  end

  def owed_by_user(group_ious, user)
    return group_ious.select{|debt| debt.reconciled == false && debt.debtor_id == user.id}
  end


  def balance(group, user = nil)
    # puts "BALANCING"
    if user.nil? == false # if you pass in a specific user

      # get total amount owed to me by user
      positive_balance = 0
      if self.owed(group, user)[0] != nil
        they_owe = self.owed(group, user).select{|debt| debt.reconciled == false}
        they_owe.each{|debt| positive_balance += debt.amount}
      end

      # get total amount owed to user by me
      negative_balance = 0
      if user.owed(group, self)[0] != nil
        self_owes = user.owed(group, self).select{|debt| debt.reconciled == false}
        self_owes.each{|debt| negative_balance -= debt.amount}
      end

      # add together
      total_balance = positive_balance + negative_balance
      # return user.id and an amount (decide what positive/negative numbers mean)
      return {user_id: user.id, balance: total_balance.to_f}
    else
      # run this same method, but iterate through all users
      other_users = group.users.select{|user| !(user == self)}
      other_users.map do |user|
        self.balance(group, user)
      end
    end

  end
end
