require 'spec_helper'

describe "ItemPages" do
  subject { page }

  describe "item index page" do
    before(:all) { 30.times { FactoryGirl.create(:item) } }
    after(:all)  { Item.delete_all }

    before(:each) { visit items_path }

    it "should list each item" do
      Item.all.each do |item|
        page.should have_selector('li', text: item.name)
      end
    end
  end

  describe "item show page" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit item_path(item) }

    it { should have_selector('h1', text: item.name) }
    it { should have_content(item.description) }
    it { should have_content(item.price) }
  end
end
