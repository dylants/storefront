require 'spec_helper'

describe "HomePages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_selector('title', text: "Taco Trade") }
    it { should have_selector('h1', text: "Welcome to the Taco Trade!") }
    it { should have_content("Where the taco meat can't be beat!") }
  end

end


