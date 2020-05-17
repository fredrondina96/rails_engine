# require "rails_helper"
#
# Rails.application.load_tasks
#
# describe "import_csv.rake" do
#   it "deletes old customers and loads in new from csv" do
#     customer = Customer.create!(first_name: "Jim", last_name: "Bo")
#     expect(Customer.first.first_name).to eq("Jim")
#     expect(Customer.first.last_name).to eq("Bo")
#     expect(Customer.all.length).to eq(1)
#     Rake::Task["import_csv"].invoke
#     expect(Customer.first.first_name).to eq("Joey")
#     expect(Customer.first.last_name).to eq("Ondricka")
#     expect(Customer.all.length).to eq(1000)
#   end
# end
