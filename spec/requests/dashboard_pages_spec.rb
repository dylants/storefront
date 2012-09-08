require 'spec_helper'

describe "DashboardPages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  before do
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