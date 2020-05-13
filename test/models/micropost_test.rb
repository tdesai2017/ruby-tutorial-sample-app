require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    #This code is not idiomatically correct.
    #Builds a micropost for @user
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end
  
  #Reality check
  test "should be valid" do
    assert @micropost.valid?
  end
  
  #test of presence with user_id correlation
  test "user id should be present" do 
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  test "content should be present" do 
    @micropost.content = "   "
    assert_not @micropost.valid?
  end
  
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
  
  #Ensures retrieval of posts in reverse order
  test "order should be most recent first" do 
    assert_equal microposts(:most_recent), Micropost.first
  end
end
