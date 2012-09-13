require 'spec_helper'

describe "HomePages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }

    it { should have_selector('title', text: I18n.t('site_name')) }
    it { should have_selector('img', alt: I18n.t('home.index.site_heading')) }
    it { should have_content(I18n.t('home.index.site_description')) }
    it { should have_content(I18n.t('home.index.site_instructions')) }
    it { should have_link(I18n.t('home.index.view')) }
    it { should have_link(I18n.t('home.index.sign_in')) }
    it { should have_link(I18n.t('home.index.register')) }
  end

end


