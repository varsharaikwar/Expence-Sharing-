class User < ApplicationRecord
  has_many :expenses
  has_many :debts, foreign_key: "debtor_id"
end
