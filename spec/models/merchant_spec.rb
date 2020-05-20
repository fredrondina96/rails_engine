require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe "methods" do
    it "filter_by_name" do
      merchant1 = Merchant.create!(name: "Jims")
      merchant2 = Merchant.create!(name: "BoB")
      merchant3 = Merchant.create!(name: "Tim")
      merchant4 = Merchant.create!(name: "Timmy")
      expect(Merchant.filter_by_name('Tim')).to eq([merchant3, merchant4])
    end
  end
end
