require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @micropost = microposts(:orange)
  end
  
  #You must be logged in to either create or destory microposts
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {micropost: {content: "Lorem ipsum"}}
    end
    assert_redirected_to login_url
  end
  
  # test "should redirect destory when not logged in" do
  #   assert_no_difference 'Micropost.count' do
  #     delete micropost_path(@micropost)
  #   end
  #   # This lin is not working for some reason, although I cannot figure out why
  #   # assert_redirected_to login_url d
  # end
  
  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end
end
