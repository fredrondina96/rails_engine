desc 'Say hello!'
task :import_csv => :environment do
  Customer.destroy_all
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
end
