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

  it "can update an item" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)
    original_item = item3

    item_params = {name: "Updated Name", description: "Updated Desc", unit_price: 44.44, merchant_id: merchant1.id}
    patch "/api/v1/items/#{item3.id}", params: {item: item_params}
    expect(response).to be_successful
    updated_item = Item.find(item3.id)
    expect(updated_item.name).to eq("Updated Name")
    expect(updated_item.name).to_not eq(original_item.name)
  end

  it "can create an item" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)

    new_item_params = {name: "Updated Name", description: "Updated Desc", unit_price: 44.44, merchant_id: merchant1.id}

    post "/api/v1/items", params: {item: new_item_params}
    expect(response).to be_successful
    new_item = Item.last
    expect(new_item.name).to eq(new_item_params[:name])
    item = JSON.parse(response.body)['data']
    expect(item['attributes']['name']).to eq(new_item_params[:name])
    expect(item['attributes']['description']).to eq(new_item_params[:description])
  end

  it "can delete an item" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)

    delete "/api/v1/items/#{item3.id}"
    expect(response).to be_successful
    expect(Item.all.count).to eq(2)
    expect{Item.find(item3.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can return the merchant an item belongs to" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "Example1", description: "D1", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)

    get "/api/v1/items/#{item1.id}/merchant"
    expect(response).to be_successful
    merchant_info = JSON.parse(response.body)["data"]
    expect(merchant_info["id"]).to eq(merchant1.id.to_s)
    expect(merchant_info["attributes"]["name"]).to eq("Jims")
  end

  it "can send an exact item matching a search" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "chair", description: "you can sit on it", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "Example3", description: "D3", unit_price: 33.33)
    get "/api/v1/items/find?name=chair"
    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]
    expect(item["attributes"]["description"]).to eq("you can sit on it")
    expect(item["id"]).to eq(item1.id.to_s)
  end

  it "can send the closest item matching a search" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "chair", description: "you can sit on it", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "aeiou", description: "D3", unit_price: 33.33)
    get "/api/v1/items/find?name=ae"
    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]
    expect(item["attributes"]["description"]).to eq("D3")
    expect(item["id"]).to eq(item3.id.to_s)
  end

  it "can send multiple items matching a search" do
    merchant1 = Merchant.create!(name: "Jims")
    item1 = merchant1.items.create!(name: "chair", description: "you can sit on it", unit_price: 31.11)
    item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
    item3 = merchant1.items.create!(name: "aeiou", description: "D3", unit_price: 33.33)
    get "/api/v1/items/find_all?description=D"
    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]
    expect(item.length).to eq(2)
    expect(item.first["attributes"]["description"]).to eq("D2")
    expect(item.last["attributes"]["description"]).to eq("D3")
  end

end
