require 'spec_helper'

describe "DashboardPages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  before do
    sign_in user
    visit dashboard_path
  end

  describe "dashboard overview" do
    it { should have_content(I18n.t('dashboard.index.title')) }
    it { should have_content(I18n.t('dashboard.index.items_purchased')) }
    it { should have_content(I18n.t('dashboard.index.items_for_sale')) }
    it { should have_content(I18n.t('dashboard.index.items_sold')) }
  end

end