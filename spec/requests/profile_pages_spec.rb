require 'spec_helper'

describe "Profile Pages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  describe "profile overview" do
    it { should have_content("Edit Profile")}
    it { should have_content("Full name") }
    it { should have_content("Email") }
    it { should have_content("Password") }
    it { should have_content("Password confirmation") }
    it { should have_content("Current password") }
  end

end