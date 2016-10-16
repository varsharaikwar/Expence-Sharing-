class User < ApplicationRecord
  has_many :purchases, class_name "Expense"
  has_many :debts
end
