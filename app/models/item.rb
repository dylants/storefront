# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Item < ActiveRecord::Base
  attr_accessible :name, :description, :price

  has_many :orders
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :user_id, presence: true

  def buy_item(buyer)
    orders.create!(buyer_id: buyer.id, seller_id: user.id)
  end
end
