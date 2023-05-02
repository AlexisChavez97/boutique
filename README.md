# boutique

## Setup

### Install dependencies
bundle install

### Run tests
rake test

### How to use
* Create an item
item = Item.new(name: "book", price: 12.49, category: :book)
* Create a cart
cart = Cart.new
* Add items to cart
cart.add(item)
* Create and print a receipt
receipt = cart.checkout
