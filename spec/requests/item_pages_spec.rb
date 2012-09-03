require 'spec_helper'

describe "ItemPages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  describe "item index page" do
    before(:all) { 30.times { FactoryGirl.create(:item) } }
    after(:all)  { Item.delete_all }

    before(:each) { visit items_path }

    it { should have_selector('title', text: 'All Tacos')}

    it "should list each item" do
      Item.all.each do |item|
        page.should have_selector('li', text: item.name)
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
      before { sign_in user }

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
        let(:item_to_edit) { user.list_item_for_sale(FactoryGirl.create(:item)) }
        before { visit edit_item_path item_to_edit }

        it { should have_selector('title', text: item_to_edit.name) }
        it { should have_selector('h2', text: "Edit #{item_to_edit.name}") }
      end
    end
  end
end
