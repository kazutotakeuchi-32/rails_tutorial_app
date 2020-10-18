require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get login_path
    assert_response :success
  end
# session 一連の処理の始まりから終わりまでを表す概念
#Cookie クライアントに保存された情報

end
