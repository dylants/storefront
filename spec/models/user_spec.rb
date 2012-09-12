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

require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:items_for_sale) }
  it { should respond_to(:items_sold) }
  it { should respond_to(:items_purchased) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email is not valid" do
    before { @user.email = "biff.com" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = "" }
    it { should_not be_valid }
  end

  describe "when password_confirmation is not present" do
    before { @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password does not match password_confirmation" do
    before { @user.password_confirmation = "NOtAmatch" }
    it { should_not be_valid }
  end

  describe "item associations" do
    before { @user.save }
    let(:item_name) { "A Great Item" }
    let(:item_type) { Item.taco }
    let(:item_description) { "Really super cool!" }
    let(:item_price) { "4.93" }

    describe "list an item for sale" do
      before do
        @user.items.create(name: item_name,
                           item_type: item_type,
                           description: item_description,
                           price: item_price)
      end

      let(:listed_item) { @user.items_for_sale.first }

      it "listed_item matches items_for_sale" do
        listed_item.name.should == item_name
        listed_item.item_type.should == item_type
        listed_item.description.should == item_description
        listed_item.price.to_s.should == item_price
      end
    end
  end

end
