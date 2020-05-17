class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.decimal :unit_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
