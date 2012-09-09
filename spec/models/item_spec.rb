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

require 'spec_helper'

describe Item do

  let(:user) { FactoryGirl.create(:user) }
  before { @item = user.items.build(name: "a name",
                                    item_type: "Taco",
                                    description: "something",
                                    price: "4.99") }

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:item_type) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }
  it { should respond_to(:user) }
  it { should respond_to(:buy_item!) }
  it { should respond_to(:has_been_purchased?) }

  it { should be_valid }

  describe "when name is not present" do
    before { @item.name = "" }
    it { should_not be_valid }
  end

  describe "when item_type is not present" do
    before { @item.item_type = "" }
    it { should_not be_valid }
  end

  describe "when item_type is one of the valid types" do
    it "should be valid" do
      valid_types = [ "Taco", "Hot Sauce", "Chips" ]
      valid_types.each do |valid_type|
        @item.item_type = valid_type
        @item.should be_valid
      end
    end
  end

  describe "when item_type is invalid" do
    before { @item.item_type = "Helmet" }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @item.description = "" }
    it { should_not be_valid }
  end

  describe "when price is not present" do
    before { @item.price = "" }
    it { should_not be_valid }
  end

  describe "when price is 0.00" do
    before { @item.price = "0.00" }
    it { should_not be_valid }
  end

  describe "when price less than 0.00" do
    before { @item.price = "-0.01" }
    it { should_not be_valid }
  end
end
