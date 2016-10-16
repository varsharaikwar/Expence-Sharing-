class Expense < ApplicationRecord
  has_many :debts
  has_many :debtors, through: :debts, class_name: "User"
  belongs to :creditor, class_name: "User"
end
