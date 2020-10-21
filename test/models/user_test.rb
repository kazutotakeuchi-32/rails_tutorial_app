require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
      @user = User.new(name:"Example User",email:"user@example.com",
                      password:"foobar",password_confirmation:"foobar")
    end

    test "authenticated？ should return false for a user with nil digest" do
      assert_not @user.authenticated?(:remember,'')
    end

    test "should be valid" do
      assert @user.valid?
    end

    test "name should be present" do
      @user.name = "  "
      assert_not @user.valid?
    end

    test "email should be present" do
      @user.email  = " "
      assert_not @user.valid?
    end

    test "name should not be too long" do
      @user.name = "a"*51
      assert_not @user.valid?
    end

    test "email should email be too lomg" do
      @user.email ="a"*244+"@example.com"
    end

    test "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_addresse|
        assert @user.valid? ,"#{valid_addresse.inspect} should be valid"
      end
    end

    test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end

    test "email addresses should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      assert_not duplicate_user.valid?
    end

    test "email addresses should be saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
    end

    test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation =""*6
      assert_not @user.valid?
    end

    test "password should have a minimum length" do
      @user.password = @user.password_confirmation ="a"*5
      assert_not @user.valid?
    end


end
# アーキテクチャ ＝＝構築スタイル、構築方式、システムを作る上での作法や様式を表す
# アーキテクチャスタイルは「ある特徴を持ったアーキテクチャの一種のこと
# https://qiita.com/Ryoga_aoym/items/7a5a12420a3fecf629ba
# RESTとは
#Webのアーキテクチャスタイルで下記の６つ特徴を組み合わせたアーキテクチャスタイル
#ネットワークシステムのアーキテクチャスタイルとなる
# 1クライアント/サーバ
# クライアントとサーバで通信のやりとりをする
# 2. ステートレスサーバ
# アプリの状態をサーバで管理しない
# 3キャッシュ
# サーバーとの通信回数を減らす
# 4統一インターフェース
# 通信のルールを統一する
# 5階層化システム
# システムを階層に分離する
#




# RESTとはWebのアーキテクチャスタイルで下記の６つ特徴を組み合わせたアーキテクチャスタイル。
# ネットワークシステムのアーキテクチャスタイルとなる。
