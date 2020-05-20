require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "methods" do
    it "can filter items by name" do
      merchant1 = Merchant.create!(name: "Jims")
      item1 = merchant1.items.create!(name: "chair", description: "you can sit on it", unit_price: 31.11)
      item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
      item3 = merchant1.items.create!(name: "aeiou", description: "D3", unit_price: 33.33)
      expect(Item.filter_by_name('chair')).to eq([item1])
    end

    it "can filter items by description" do
      merchant1 = Merchant.create!(name: "Jims")
      item1 = merchant1.items.create!(name: "chair", description: "you can sit on it", unit_price: 31.11)
      item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
      item3 = merchant1.items.create!(name: "aeiou", description: "D3", unit_price: 33.33)
      expect(Item.filter_by_description('D')).to eq([item2, item3])
    end

    it "can filter items by unit_price" do
      merchant1 = Merchant.create!(name: "Jims")
      item1 = merchant1.items.create!(name: "chair", description: "you can sit on it", unit_price: 31.11)
      item2 = merchant1.items.create!(name: "Example2", description: "D2", unit_price: 32.22)
      item3 = merchant1.items.create!(name: "aeiou", description: "D3", unit_price: 33.33)
      expect(Item.filter_by_unit_price(33.33)).to eq([item3])
    end

  end
end
