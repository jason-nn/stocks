class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :action
      t.integer :amount
      t.string :stock, default: nil
      t.integer :quantity, default: nil
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
