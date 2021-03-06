class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.bigint :credit_card_number
      t.date :credit_card_expiration_date, :default => "11/11/11"
      t.string :result

      t.timestamps
    end
  end
end
