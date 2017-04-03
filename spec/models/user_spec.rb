require 'rails_helper'

RSpec.describe User, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
  	@user = User.new(first_name: "Example User", email: "user@example.com", last_name: "Last", birthday: "19.02.1990", password: "12345678", username: "UserName")
  end

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:password) }
  it { should respond_to(:last_name) }

  it { should be_valid }

  describe "when USERNAME is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when PASSWORD is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

    describe "when EMAIL is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when PASSWORD is > 8 CHAR" do
    before { @user.password = "#{1..30}.to_a.join" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

    describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end
end
