require "rspec"

describe "Authentication" do

  subject { page }

  describe "before logging in" do
    before { visit root_path }

    it { should have_content("Sign In") }
    it { should have_content("Register") }
  end

  describe "login" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit root_path
      click_link "Sign In"
    end

    describe "login succeed" do
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_content("Sign Out") }
    end

    describe "login fail" do
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: "bad_password"
        click_button "Sign in"
      end

      it { should have_content("Invalid email or password") }
    end
  end

end