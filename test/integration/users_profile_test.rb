require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  #By including application helper, we can use full_title from application_helper.rb
  include ApplicationHelper
  
  def setup
    @user = users(:michael)
  end
  
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title',  full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    #Response.body in this context actually refers to info anywhere on the page, not just in the body
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
