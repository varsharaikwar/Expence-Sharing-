class ChangeColumnInExpenses < ActiveRecord::Migration[5.0]
  def change
    rename_column :expenses, :creditor_id, :user_id
  end
end
