class Item <ApplicationRecord

  validates_presence_of :name, :description, :unit_price
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.filter_by_name(name)
    @items = self.where(Item.arel_table[:name].lower.matches("%#{name.downcase}%"))
  end

  def self.filter_by_description(description)
    @items = self.where(Item.arel_table[:description].lower.matches("%#{description.downcase}%"))
  end

  def self.filter_by_unit_price(unit_price)
    @items = self.where(unit_price: unit_price)
  end
end
