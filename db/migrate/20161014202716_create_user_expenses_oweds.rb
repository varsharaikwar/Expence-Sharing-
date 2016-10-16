class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.decimal :amount
      t.boolean :reconciled

      t.references :expense
      t.references :debtor

      t.timestamps
    end
  end
end
