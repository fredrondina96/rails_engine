desc 'Say hello!'
task :import_csv => :environment do
  Item.destroy_all
  Transaction.destroy_all
  Invoice.destroy_all
  Customer.destroy_all
  Merchant.destroy_all

  ActiveRecord::Base.connection.tables.each do |t|
          ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  csv_text = File.read(Rails.root.join('lib', 'data', 'customers.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      new_customer = Customer.new
      new_customer.first_name = row["first_name"]
      new_customer.last_name = row["last_name"]
      new_customer.created_at = row["created_at"]
      new_customer.updated_at = row["updated_at"]
      new_customer.save
    end

  csv_text = File.read(Rails.root.join('lib', 'data', 'merchants.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      new_merchant = Merchant.new
      new_merchant.name = row["name"]
      new_merchant.created_at = row["created_at"]
      new_merchant.updated_at = row["updated_at"]
      new_merchant.save
    end

  csv_text = File.read(Rails.root.join('lib', 'data', 'items.csv'))
  csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      new_item = Item.new
      new_item.name = row["name"]
      new_item.description = row["description"]
      new_item.merchant_id = row["merchant_id"]
      new_item.created_at = row["created_at"]
      new_item.updated_at = row["updated_at"]
      new_item.unit_price = row["unit_price"].insert(-3, '.').to_f
      new_item.save
    end

    csv_text = File.read(Rails.root.join('lib', 'data', 'invoices.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
      csv.each do |row|
        new_invoice = Invoice.new
        new_invoice.status = row["status"]
        new_invoice.customer_id = row["customer_id"]
        new_invoice.merchant_id = row["merchant_id"]
        new_invoice.created_at = row["created_at"]
        new_invoice.updated_at = row["updated_at"]
        new_invoice.save
      end

    csv_text = File.read(Rails.root.join('lib', 'data', 'transactions.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
      csv.each do |row|
        new_transaction = Transaction.new
        new_transaction.result = row["result"]
        new_transaction.invoice_id = row["invoice_id"]
        new_transaction.credit_card_number = row["credit_card_number"]
        new_transaction.credit_card_expiration_date = row["credit_card_expiration_date"] unless row["credit_card_expiration_date"].nil?
        new_transaction.created_at = row["created_at"]
        new_transaction.updated_at = row["updated_at"]
        new_transaction.save
      end
end
