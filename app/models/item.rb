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
#  item_type   :string(255)
#

class Item < ActiveRecord::Base
  attr_accessible :name, :item_type, :description, :price

  has_one :order
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :item_type, presence: true, inclusion: { in: [ "Taco", "Hot Sauce", "Chips" ] }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :user_id, presence: true

  def buy_item!(buyer)
    Order.create!(buyer_id: buyer.id, seller_id: user.id, item_id: self.id)
  end

  def has_been_purchased?
    Order.find_by_item_id(self.id)
  end
end
