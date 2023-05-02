# frozen_string_literal: true

require_relative "receipt"

class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item, quantity)
    items << [item, quantity]
  end

  def checkout
    Receipt.process(items)
  end
end