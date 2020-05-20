class Merchant < ApplicationRecord

  validates_presence_of :name
  has_many :items
  has_many :invoices

  def self.filter_by_name(name)
    @merchants = self.where(Merchant.arel_table[:name].lower.matches("%#{name.downcase}%"))
  end
end
