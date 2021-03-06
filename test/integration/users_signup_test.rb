require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear

  end

  test "invalid signup infrmation" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path,params:{user:{
        name:  "",
        email: "user@invalid",
        password:              "foo",
        password_confirmation: "bar"
      }}
    end
    assert_template 'users/new'
    assert_select 'div.alert' ,"The form contains 4 errors."
    assert_select 'div#error_explanation'
    assert_select 'ul' do
      assert_select 'li', 'Name can\'t be blank'
      assert_select 'li', 'Email is invalid'
      assert_select 'li', 'Password confirmation doesn\'t match Password'
      assert_select 'li', 'Password is too short (minimum is 6 characters)'
    end
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count',1 do
      post users_path,params:{user:{
        name:  "Example User",
        email: "user@example.com",
        password:              "password",
        password_confirmation: "password"
        }
        }
    end
    assert_equal 1,ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as(user)
    assert_not is_logged_in?
    get edit_account_activation_path("invaild token",email:user.email)
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token,email:"wrong")
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token,email:user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end


end
