require 'spec_helper'

describe "OrderPages" do
  let(:buyer) { FactoryGirl.create(:user) }
  let(:seller) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item) }

  subject { page }

  before { seller.list_item_for_sale(item) }

  describe "can buy an item" do

    describe "as a non-authenticated user" do
      before { visit item_path(item) }

      it { should_not have_button("Buy Taco") }
    end

    describe "as an authenticated user" do
      before do
        sign_in buyer
        visit item_path(item)
      end

      it { should have_button("Buy Taco") }
    end
  end

  describe "buy an item" do
    before do
      sign_in buyer
      visit item_path(item)
      click_button "Buy Taco"
    end

    it { should have_content("Taco Dashboard") }
    it { should have_content("You have successfully purchased the #{item.name}!") }

    # and if you visit the item again, it should say purchased
    it "verify item shows purchased" do
      visit item_path(item)
      page.should_not have_button("Buy Taco")
    end
  end

end