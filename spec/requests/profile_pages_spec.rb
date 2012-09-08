require 'spec_helper'

describe "Profile Pages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  before do
    sign_in user
    visit profile_path
  end

  describe "profile overview" do
    it { should have_link("Edit email address") }
    it { should have_link("Edit password") }
  end

end