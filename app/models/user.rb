class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews

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
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.username = auth_hash["info"]["nickname"]
    user.email = auth_hash["info"]["email"]
    return user
  end
end
