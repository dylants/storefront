require 'spec_helper'

describe "DashboardPages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item) }

  subject { page }

  before do
    user.list_item_for_sale(item)
    sign_in user
    visit dashboard_path
  end

  describe "dashboard overview" do
    it { should have_content("Taco Dashboard") }
    it { should have_content("Tacos for sale") }
    it { should have_content("Tacos sold") }
    it { should have_content("Tacos purchased") }
  end

end