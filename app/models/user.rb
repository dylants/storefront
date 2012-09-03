# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :items
  has_many :orders_sold, foreign_key: "seller_id", class_name: "Order"
  has_many :items_sold, through: :orders_sold, source: :item
  has_many :orders_purchased, foreign_key: "buyer_id", class_name: "Order"
  has_many :items_purchased, through: :orders_purchased, source: :item

  validates :name, presence: true, length: { :maximum => 50 }

  def list_item_for_sale(item)
    self.items.create!(name: item.name, description: item.description, price: item.price)
  end

  def items_for_sale
    self.items.all - self.items_sold
  end
end
