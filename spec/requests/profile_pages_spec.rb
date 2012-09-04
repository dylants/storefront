require 'spec_helper'

describe "Profile Pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item) }

  subject { page }

  before do
    user.list_item_for_sale(item)
    sign_in user
    visit profile_path
  end

  describe "profile overview" do
    it { should have_link("Edit email address") }
    it { should have_link("Edit password") }
  end

end