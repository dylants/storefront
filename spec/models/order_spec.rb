# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  buyer_id   :integer
#  seller_id  :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Order do

  let(:buyer) { FactoryGirl.create(:user) }
  let(:seller) { FactoryGirl.create(:user) }
  let(:listed_item) do
    item = FactoryGirl.create(:item)
    seller.list_item_for_sale(item)
  end
  let(:order) { listed_item.buy_item(buyer) }

  subject { order }

  describe "verify relationships" do
    it { should respond_to(:buyer) }
    it { should respond_to(:seller) }
    it { should respond_to(:item) }
    its(:buyer) { should == buyer }
    its(:seller) { should == seller }
    its(:item) { should == listed_item }
  end
end
