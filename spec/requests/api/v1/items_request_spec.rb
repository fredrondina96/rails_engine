require 'rails_helper'

describe "items API" do
  it "can send a list of all items" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)

    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items["data"].length).to eq(3)
  end

  it "can return a specific item" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)
    get "/api/v1/items/#{item3.id}"
    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["data"]["id"]).to eq(item3.id.to_s)
    expect(item["data"]["attributes"]["name"]).to eq(item3.name)
  end
end