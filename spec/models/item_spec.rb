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
#

require 'spec_helper'

describe Item do

  before do
    @item = Item.new(name: "iPod", description: "brand new 8GB iPod", price: 99.99)
  end

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
end
