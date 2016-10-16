class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :notes
      t.date :date
      t.decimal :amount
      t.decimal :share

      t.references :creditor

      t.timestamps
    end
  end
end
