require 'rails_helper'

describe "Merchants API" do

  it "sends a list of merchants" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "Tims")
    merchant3 = Merchant.create!(name: "Dougs")
    merchant4 = Merchant.create!(name: "Bobs")

    get "/api/v1/merchants"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(4)
  end
end
