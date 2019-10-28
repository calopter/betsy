ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
# require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest/skip_dsl'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def add_to_cart(product = products(:p_1), quantity = 1)
    order_item_params = { order_item: { quantity: quantity } }
    post add_to_cart_path(product), params: order_item_params
    return product
  end

  def find_cart
    @cart ||= Order.find_by(id: session[:order_id])
  end
end
