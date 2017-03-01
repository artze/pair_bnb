class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :reservation, index: true, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end