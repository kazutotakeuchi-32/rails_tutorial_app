require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @user = users(:malory)
    @non_admin = users(:archer)
    @non_activated = users(:kazuto)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "div.pagination",count: 2
    first_page_of_users = User.where(activated:true).paginate(page:1)
    first_page_of_users.each do |user|
        assert_select 'a[href=?]',user_path(user),text:user.name
      unless user == @admin
        assert_select 'a[href=?]',user_path(user),text:'delete'
      end
    end
    assert_difference 'User.count',-1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a',text:'delete',count:0
  end

  test "redirect by root if account activation is not possible" do
    log_in_as(@admin)
    get user_path(@non_activated)
    assert_not @non_activated.activated?
    assert_redirected_to root_url
  end

  test "If your account is valid, jump to the details page" do
    log_in_as(@admin)
    get user_path(@user)
    assert @user.activated?
    assert_template "users/show"
  end

end
