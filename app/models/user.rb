class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews
  
  validates :email, presence: true, on: :verify_user_at_purchase
  validates :cc_name, presence: true, on: :verify_user_at_purchase
  validates :cc_number, presence: true, on: :verify_user_at_purchase
  validates :cc_expiration, presence: true, on: :verify_user_at_purchase
  validates :cvv, presence: true, on: :verify_user_at_purchase
  validates :billing_zip, presence: true, on: :verify_user_at_purchase
  validates :street_address, presence: true, on: :verify_user_at_purchase
  validates :city, presence: true, on: :verify_user_at_purchase
  validates :state, presence: true, on: :verify_user_at_purchase
  validates :mailing_zip, presence: true, on: :verify_user_at_purchase
  
  def self.verify_user_at_purchase(user)
    validity = user.valid?(:verify_user_at_purchase)
    messages = user.errors.messages
    # This is eating validation errors, possibly. Connects to Order Controller complete_purchase action. Tested there. 
    if messages.any? 
      return messages
    else
      return
    end
  end
  
  def order_count
    orders.group_by(&:status).transform_values(&:count)
  end
  
  def revenue
    orders.map(&:revenue).sum
  end
  
  def revenues
    orders.group_by(&:status).transform_values do |orders|
      orders.map(&:revenue).sum
    end
  end
  
  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.username = auth_hash["info"]["nickname"]
    user.email = auth_hash["info"]["email"]
    return user
  end
end
