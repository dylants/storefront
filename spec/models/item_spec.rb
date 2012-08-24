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

  let(:item) { FactoryGirl.create(:item) }

  subject { item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  it { should be_valid }

  describe "when name is not present" do
    before { item.name = "" }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { item.description = "" }
    it { should_not be_valid }
  end

  describe "when price is not present" do
    before { item.price = "" }
    it { should_not be_valid }
  end

  describe "when price is 0.00" do
    before { item.price = "0.00" }
    it { should_not be_valid }
  end

  describe "when price less than 0.00" do
    before { item.price = "-0.01" }
    it { should_not be_valid }
  end
end
