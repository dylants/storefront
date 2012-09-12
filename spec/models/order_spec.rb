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
  let(:listed_item) { FactoryGirl.create(:item, user: seller) }

  describe "buy item scenarios" do
    describe "prior to buying an item" do
      before do
        # Why must I do this again here?
        seller.items.create(name: listed_item.name,
                            item_type: listed_item.item_type,
                            description: listed_item.description,
                            price: listed_item.price)
      end

      it "verify items_sold does not include listed item" do
        seller.items_sold.should_not include listed_item
      end

      it "verify items_for_sale includes listed item" do
        seller.items_for_sale.should include listed_item
      end

      it "verify items_purchased does not include listed item" do
        buyer.items_purchased.should_not include listed_item
      end

      it "verify item shows not purchased" do
        listed_item.has_been_purchased?.should be_false
      end
    end

    describe "after buying an item" do
      before { listed_item.buy_item!(buyer) }

      it "verify items_sold increases after buy item" do
        seller.items_sold.should include listed_item
      end

      it "verify items_for_sale increases after buy item" do
        seller.items_for_sale.should_not include listed_item
      end

      it "verify items_purchased includes listed item" do
        buyer.items_purchased.should include listed_item
      end

      it "verify item shows purchased" do
        listed_item.has_been_purchased?.should be_true
      end
    end

  end

  describe "create new order" do
    let(:order) { listed_item.buy_item!(buyer) }

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
end
