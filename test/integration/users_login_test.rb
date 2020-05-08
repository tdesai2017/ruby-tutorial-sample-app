require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "login with valid information" do
    get login_path
    post login_path, params: { session: {email: @user.email, password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
    
    
  # 1. Visit login path
  # 2. Veryfy that the new sessions form render properly
  # 3. Post tot he sessions path with an invalid params hash
  # 4. Verify that the new sessions form gets re-rendered and that a flash message appears
  # 5. Visit another page (such as the Home page).
  # 6. Verify that the flash message doesn't appear on the new page
  
 test "login with invalid formation" do 
   get login_path
   assert_template 'sessions/new'
   post login_path, params: {session: {email: "", password: ""}}
   assert_template 'sessions/new'
   assert_not flash.empty?
   get root_path
   assert flash.empty?
 end
 
 test "login with valid informtion followed by logout" do
   get login_path
   post login_path, params: { session: { email: @user.email, password: 'password'}}
   assert is_logged_in?
   follow_redirect!
   assert_template 'users/show'
   assert_select "a[href=?]", login_path, count:0
   assert_select "a[href=?]", logout_path
   assert_select "a[href=?]", user_path(@user)
   delete logout_path
   assert_not is_logged_in?
   assert_redirected_to root_url
   follow_redirect!
   assert_select "a[href=?]", login_path
   assert_select "a[href=?]", logout_path, count: 0
   assert_select "a[href=?]", user_path(@user), count:0
  end
end
