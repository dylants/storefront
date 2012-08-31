require "rspec"

describe "Authentication" do

  subject { page }

  before { visit root_path }

  describe "before logging in" do
    it { should have_content("Sign In") }
    it { should have_content("Register") }
  end

  describe "login" do
    let(:user) { FactoryGirl.create(:user) }

    before { click_link "Sign In" }

    describe "login succeed" do
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it { should have_content("Sign Out") }
    end

    describe "login fail" do
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: "bad_password"
        click_button "Sign In"
      end

      it { should have_content("Invalid email or password") }
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

      it { should have_content("You have signed up successfully") }
    end
  end
end