class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.username = auth_hash["info"]["email"]
    user.email = auth_hash["info"]["email"]


    # Note that the user has not been saved.
    # We'll choose to do the saving outside of this method
    return user
  end
end
