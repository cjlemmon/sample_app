require 'spec_helper'

describe User do
  before :each do
    @attr = { :name => 'Charles', :email => 'cjlemmon@yahoo.com'}
  end

  it 'should create a valid user given valid attributes' do
    user = User.create! @attr
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should limit length of name to 50" do
    a_name = "a" * 51
    print a_name + "\n"
    @attr = @attr.merge(:name => a_name)
    user = User.new( @attr )
    user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

end

