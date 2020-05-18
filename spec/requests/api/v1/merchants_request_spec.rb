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

 it "It can update a merchants attributes" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "Tims")
    merchant3 = Merchant.create!(name: "Dougs")
    merchant4 = Merchant.create!(name: "Bobs")
    original_name = Merchant.last.name

    updated_merchant_params = {name: "The Updated One"}
    patch "/api/v1/merchants/#{merchant4.id}", params: {merchant: updated_merchant_params}
    expect(response).to be_successful
    updated_merchant = Merchant.last
    expect(updated_merchant.name).to_not eq(original_name)
    expect(updated_merchant.name).to eq("The Updated One")
  end

  it "can create a new merchant" do
    merchant1 = Merchant.create!(name: "Jims")
    new_merchant_params = {name: "The New One"}

    post "/api/v1/merchants", params: {merchant: new_merchant_params}
    expect(response).to be_successful
    new_merchant = Merchant.last
    expect(new_merchant.name).to eq("The New One")
  end

  it "can delete a merchant" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "Tims")
    merchant3 = Merchant.create!(name: "Dougs")
    merchant4 = Merchant.create!(name: "Bobs")

    delete "/api/v1/merchants/#{merchant4.id}"
    expect(response).to be_successful
    expect(Merchant.all.count).to eq(3)
    expect{Merchant.find(merchant4.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
