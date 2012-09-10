require 'spec_helper'

describe "DashboardPages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  before do
    sign_in user
    visit dashboard_path
  end

  describe "dashboard overview" do
    it { should have_content("Taco Trade Dashboard") }
    it { should have_content("Items for sale") }
    it { should have_content("Items sold") }
    it { should have_content("Items purchased") }
  end

end