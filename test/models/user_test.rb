require 'test_helper'

#This is creating a new valid user, and then testing whether it correctly is
#correctly labeled as invalid if the name or email is blank

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    #changes the user from setup's name to "" and wants to ensure that this is regarded as not valid
    @user.name = ""
    assert_not @user.valid?
  end
  
  #Remember, setup is run before "email should be present", so the user is back
  #to being valid beforehand
  
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "email should not be too long" do 
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  #Are there no problems with saving a user to the database here...is this 
  #automatically rolled back?
  
  # --> https://stackoverflow.com/questions/437760/where-does-rails-store-data-created-by-saving-activerecord-objects-during-tests
  #They are automatically rolled back, as explained here
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be present (nonblank)" do 
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "associated microposts should be destoryed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end      
end



