# frozen_string_literal: true

class Receipt
  attr_reader :items
  
  def self.process(*args)
    new(*args).print
  end

  def initialize(items)
    @items = items
  end

  def print
    return "No items in cart" if items.empty?

    receipt = []
    receipt << receipt_body
    receipt << receipt_footer
    receipt.join("\n")
  end

  private

  def receipt_body
    items.map do |item, quantity|
      "#{quantity} #{item.name}: #{format_money(item.net_price * quantity)}"
    end
  end

  def receipt_footer
    ["Sales Taxes: #{format_money(total_taxes)}", "Total: #{format_money(total_price)}"]
  end

  def format_money(amount)
    format("%.2f", amount)
  end

  def total_taxes
    items.sum { |item, quantity| item.tax * quantity }
  end

  def total_price
    items.sum { |item, quantity| item.net_price * quantity }
  end
end