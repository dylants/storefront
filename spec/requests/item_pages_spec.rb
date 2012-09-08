require 'spec_helper'

describe "ItemPages" do
  let(:buyer) { FactoryGirl.create(:user) }
  let(:seller) { FactoryGirl.create(:user) }

  subject { page }

  describe "item index page" do
    before(:all) do
      # create 10 items, listing them all for sale
      for i in 1..10
        FactoryGirl.create(:item, user: seller)
      end

      # let's buy... 5 of them, so that some are still for sale
      items = Item.find_all_by_user_id(seller.id)
      for i in 1..5
        item = items[i]
        item.buy_item!(buyer)
      end
    end

    after(:all)  { Item.delete_all }

    before(:each) { visit items_path }

    it { should have_selector('title', text: 'Tacos for Sale') }

    it "should list each item" do
      Item.all.each do |item|
        if item.has_been_purchased?
          page.should_not have_selector('li', text: item.name)
        else
          page.should have_selector('li', text: item.name)
        end
      end
    end
  end

  describe "item show page" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit item_path(item) }

    it { should have_selector('title', text: item.name) }
    it { should have_selector('h2', text: item.name) }
    it { should have_content(item.description) }
    it { should have_content(item.price) }
  end

  describe "item new page" do
    describe "non-authenticated user" do
      before { visit new_item_path }

      it { should have_content("You need to sign in or sign up before continuing") }
    end

    describe "authenticated user" do
      before { sign_in seller }

      describe "create item" do
        let(:item_name) { "Random New Taco" }
        let(:item_description) { "This is the random description of the taco" }
        let(:item_price) { "2.99" }
        let(:submit) { "Add" }

        before do
          visit new_item_path
          fill_in "Name", with: item_name
          fill_in "Description", with: item_description
          fill_in "Price", with: item_price
        end

        it "should create an item" do
          expect { click_button submit }.to change(Item, :count).by(1)
        end

        describe "after creating an item" do
          before { click_button submit }

          it { should have_selector('title', text: item_name) }
          it { should have_selector('h2', text: item_name) }
          it { should have_content(item_description) }
          it { should have_content(item_price) }
        end
      end

      describe "edit item" do
        let(:item_to_edit) { FactoryGirl.create(:item, user: seller) }
        before { visit edit_item_path item_to_edit }

        it { should have_selector('title', text: item_to_edit.name) }
        it { should have_selector('h2', text: "Edit #{item_to_edit.name}") }
      end
    end
  end
end
