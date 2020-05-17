desc 'Say hello!'
task :import_csv => :environment do
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
end
