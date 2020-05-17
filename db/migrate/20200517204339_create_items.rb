class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      # t.decimal :unit_price, precision: 8, scale: 2
      t.float :unit_price
      t.timestamps
    end
  end
end
