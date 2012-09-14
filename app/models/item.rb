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
  validates :item_type, presence: true, inclusion: { in: %w{taco hot_sauce chips} }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :user_id, presence: true

  # Tire/elasticsearch configuration
  include Tire::Model::Search
  include Tire::Model::Callbacks
  # this index is defined in the elasticsearch.rb
  index_name ELASTICSEARCH_INDEX_NAME

  def buy_item!(buyer)
    Order.create!(buyer_id: buyer.id, seller_id: user.id, item_id: self.id)
  end

  def has_been_purchased?
    Order.find_by_item_id(self.id)
  end

  def self.all_for_sale(item_type)
    Item.find_all_by_item_type(item_type) - Item.joins(:order)
  end

  def self.derive_item_type_from_content(content_item_type)
    if I18n.t(taco) == content_item_type
      taco
    elsif I18n.t(hot_sauce) == content_item_type
      hot_sauce
    else
      chips
    end
  end

  # our "enums" for item type
  def self.taco
    'taco'
  end
  def self.hot_sauce
    'hot_sauce'
  end
  def self.chips
    'chips'
  end
end
