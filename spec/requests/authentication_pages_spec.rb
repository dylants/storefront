require "rspec"

describe "Authentication" do

  subject { page }

  before { visit root_path }

  describe "before logging in" do
    it { should have_link("Sign In") }
    it { should have_link("Register") }
    it { should_not have_link("Dashboard") }
    it { should_not have_link("Profile")}
  end

  describe "login" do
    let(:user) { FactoryGirl.create(:user) }

    before { click_link "Sign In" }

    describe "login succeed" do
      before do
        sign_in user
        # navigate to something other than home page
        visit items_path
      end

      it { should have_link("Dashboard") }
      it { should have_link("Profile") }
      it { should have_link("Sign Out") }
      it { should_not have_link("Sign In") }
      it { should_not have_link("Register") }
    end

    describe "login fail" do
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: "bad_password"
        click_button "Sign In"
      end

      it { should have_content("Invalid email or password") }
      it { should have_link("Sign In") }
      it { should have_link("Register") }
      it { should_not have_link("Dashboard") }
      it { should_not have_link("Profile")}
    end
  end

  describe "register" do
    let(:user_name) { "BiffTest" }
    let(:user_email) { "bifftest@example.com" }
    let(:user_password) { "bifftest" }

    before { click_link "Register" }

    it { should have_content("Register New User")}

    describe "new user" do
      before do
        fill_in "Name",                   with: user_name
        fill_in "Email",                  with: user_email
        fill_in "Password",               with: user_password
        fill_in "Password confirmation",  with: user_password
        click_button "Register"
      end

      it { should have_content("Registration Complete!") }
    end
  end
end