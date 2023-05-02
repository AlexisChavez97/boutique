# frozen_string_literal: true

require_relative "test_helper"

class ReceiptTest < Minitest::Test
  def test_receipt_prints_no_items_in_cart
    cart = Cart.new
    subject = cart.checkout
    assert_equal "No items in cart", subject
  end

  def test_receipt_prints_one_item
    item1 = Item.new(name: "book", price: 12.49, category: :book)
    cart = Cart.new
    cart.add_item(item1, 1)
    subject = cart.checkout

    assert_equal <<~RECEIPT.chomp, subject
      1 book: 12.49
      Sales Taxes: 0.00
      Total: 12.49
    RECEIPT
  end

  def test_receipt_prints_two_items_with_quantity
    item1 = Item.new(name: "music CD", price: 14.99, category: :other)
    item2 = Item.new(name: "book", price: 12.49, category: :book)
    cart = Cart.new
    cart.add_item(item1, 2)
    cart.add_item(item2, 3)
    subject = cart.checkout

    assert_equal <<~RECEIPT.chomp, subject
      2 music CD: 32.98
      3 book: 37.47
      Sales Taxes: 3.00
      Total: 70.45
    RECEIPT
  end

  def test_input_1
    item1 = Item.new(name: "book", price: 12.49, category: :book)
    item2 = Item.new(name: "music CD", price: 14.99, category: :other)
    item3 = Item.new(name: "chocolate bar", price: 0.85, category: :food)
    cart = Cart.new
    cart.add_item(item1, 2)
    cart.add_item(item2, 1)
    cart.add_item(item3, 1)
    subject = cart.checkout

    assert_equal <<~RECEIPT.chomp, subject
      2 book: 24.98
      1 music CD: 16.49
      1 chocolate bar: 0.85
      Sales Taxes: 1.50
      Total: 42.32
    RECEIPT
  end

  def test_input_2
    item1 = Item.new(name: "imported box of chocolates", price: 10.00, category: :food)
    item2 = Item.new(name: "imported bottle of perfume", price: 47.50, category: :other)
    cart = Cart.new
    cart.add_item(item1, 1)
    cart.add_item(item2, 1)
    subject = cart.checkout

    assert_equal <<~RECEIPT.chomp, subject
      1 imported box of chocolates: 10.50
      1 imported bottle of perfume: 54.65
      Sales Taxes: 7.65
      Total: 65.15
    RECEIPT
  end

  def test_input_3
    item1 = Item.new(name: "imported bottle of perfume", price: 27.99, category: :other)
    item2 = Item.new(name: "bottle of perfume", price: 18.99, category: :other)
    item3 = Item.new(name: "packet of headache pills", price: 9.75, category: :medical)
    item4 = Item.new(name: "imported boxes of chocolates", price: 11.25, category: :food)
    cart = Cart.new
    cart.add_item(item1, 1)
    cart.add_item(item2, 1)
    cart.add_item(item3, 1)
    cart.add_item(item4, 3)
    subject = cart.checkout

    assert_equal <<~RECEIPT.chomp, subject
      1 imported bottle of perfume: 32.19
      1 bottle of perfume: 20.89
      1 packet of headache pills: 9.75
      3 imported boxes of chocolates: 35.55
      Sales Taxes: 7.90
      Total: 98.38
    RECEIPT
  end
end