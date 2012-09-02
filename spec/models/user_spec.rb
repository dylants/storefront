# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#

require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "when name is not present" do
    before { user.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  describe "when email is not valid" do
    before { user.email = "biff.com" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { user.password = "" }
    it { should_not be_valid }
  end

  describe "when password_confirmation is not present" do
    before { user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password does not match password_confirmation" do
    before { user.password_confirmation = "NOtAmatch" }
    it { should_not be_valid }
  end

end
