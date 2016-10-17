class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :expenses
  has_many :debts, foreign_key: "debtor_id"

  def owed
    ious = Debt.all.select do |debt|
      if debt.reconciled == false
        debt.expense.user == self;
      end
    end
  end

  def balance(user)
    if user.nil? == false # if you pass in a specific user

      # get total amount owed to me by user
      positive_balance = 0

      they_owe = self.owed.select do |debt|
        debt.debtor == user
      end
      they_owe.each do |debt|
        positive_balance += debt.amount
      end

      # get total amount owed to user by me
      negative_balance = 0

      self_owes = user.owed.select do |debt|
        debt.debtor === self
      end

      self_owes.each do |debt|
        negative_balance -= debt.amount
      end
      # add together
      total_balance = positive_balance + negative_balance

      # return user.id and an amount (decide what positive/negative numbers mean)
      return user_id: user.id, balance: total_balance
    else
      # run this same method, but iterate through all users
      return 'dickall'
    end

  end
end
