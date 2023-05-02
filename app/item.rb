# frozen_string_literal: true

class Item
  attr_reader :name, :price, :category

  BASIC_SALES_TAX_RATE = 0.1
  IMPORT_DUTY_TAX_RATE = 0.05
  TAX_FREE_ITEMS = %i[book food medical]

  def initialize(name:, price:, category:)
    @name = name
    @price = price
    @category = category
  end

  def net_price
    (price + tax).round(2)
  end

  def tax
    ((price * tax_rate) * 20).ceil / 20.0
  end

  private

  def tax_rate
    tax_rate = 0.0
    tax_rate += BASIC_SALES_TAX_RATE unless tax_free?
    tax_rate += IMPORT_DUTY_TAX_RATE if imported?
    tax_rate
  end

  def tax_free?
    TAX_FREE_ITEMS.include?(category)
  end

  def imported?
    name.include?("imported")
  end
end