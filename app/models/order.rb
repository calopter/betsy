class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  
  # validates :status, presence: true
  # validates :status, inclusion: { in: ["pending", "paid", "complete", "cancelled"] }
  
  # def related_user_cc_expiration
  #   @login_user = User.find_by(id: "blarg")
  #   if @login_user != nil
  #     if @login_user.cc_expiration == "1121"
  #       errors.add(:cc_expiration, "The user cc expiration must exist")
  #     end
  #   end
  # end
  # validate :related_user_cc_expiration
  
  
  
end
