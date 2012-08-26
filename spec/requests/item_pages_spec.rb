require 'spec_helper'

describe "ItemPages" do
  subject { page }

  describe "item index page" do
    before(:all) { 30.times { FactoryGirl.create(:item) } }
    after(:all)  { Item.delete_all }

    before(:each) { visit items_path }

    it { should have_selector('title', text: 'All Items')}

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
    it { should have_selector('h1', text: item.name) }
    it { should have_content(item.description) }
    it { should have_content(item.price) }
  end

  describe "item new page" do
    before { visit new_item_path }

    describe "create item" do
      let(:item_name) { "Random Item Name" }
      let(:item_description) { "This is the random description of the item" }
      let(:item_price) { "22.99" }
      let(:submit) { "Create Item" }

      before do
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
        it { should have_selector('h1', text: item_name) }
        it { should have_content(item_description) }
        it { should have_content(item_price) }
      end
    end
  end
end
