require 'rails_helper'

describe "Merchants API" do

  it "returns all merchants" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "Tims")
    merchant3 = Merchant.create!(name: "Dougs")
    merchant4 = Merchant.create!(name: "Bobs")

    get "/api/v1/merchants"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(4)
  end

  it "returns the requested merchant" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "Tims")
    merchant3 = Merchant.create!(name: "Dougs")
    merchant4 = Merchant.create!(name: "Bobs")

    get "/api/v1/merchants/#{merchant2.id}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["id"]).to eq(merchant2.id.to_s)
    expect(merchant["data"]["attributes"]["name"]).to eq(merchant2.name)
 end
end
