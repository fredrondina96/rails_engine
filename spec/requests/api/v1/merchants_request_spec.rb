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

  it "can return the items of a particular merchant" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "BoB")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)
    item4 = merchant2.items.create!(name: "Example4", description: "D4", unit_price: 33.33)
    item5 = merchant2.items.create!(name: "Example5", description: "D5", unit_price: 33.33)

    get "/api/v1/merchants/#{merchant1.id}/items"
    expect(response).to be_successful
    merchant1_items = JSON.parse(response.body)["data"]
    expect(merchant1_items.length).to eq(3)
    get "/api/v1/merchants/#{merchant2.id}/items"
    merchant2_items = JSON.parse(response.body)["data"]
    expect(merchant2_items.length).to eq(2)
  end

  it "can return a single merchant searched by name" do
    merchant1 = Merchant.create!(name: "Jims")
    merchant2 = Merchant.create!(name: "BoB")
    merchant2 = Merchant.create!(name: "Tim")
    get "/api/v1/merchants/find?name=Jims"
    expect(response).to be_successful
    merchant = JSON.parse(response.body)["data"]
    expect(merchant["attributes"]["name"]).to eq("Jims")
    expect(merchant["id"]).to eq(merchant1.id.to_s)
  end

  it "can return multiple merchants searched by name" do
    merchant1 = Merchant.create!(name: "Tims")
    merchant2 = Merchant.create!(name: "BoB")
    merchant2 = Merchant.create!(name: "Timmy")
    get "/api/v1/merchants/find_all?name=Tim"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)["data"]
    expect(merchants.length).to eq(2)
    expect(merchants.first["attributes"]["name"]).to eq("Tims")
    expect(merchants.last["attributes"]["name"]).to eq("Timmy")
  end
end
