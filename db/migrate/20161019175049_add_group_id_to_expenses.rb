class AddGroupIdToExpenses < ActiveRecord::Migration[5.0]
  def change
    change_table :expenses do |t|

      t.references :group
    end
  end
end
