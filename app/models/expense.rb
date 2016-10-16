class Expense < ApplicationRecord
  has_many :debts
  has_many :debtors, through: :debts, class_name: "User", source: "debtor"
  belongs_to :user
end
