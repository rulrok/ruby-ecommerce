require 'test_helper'

class Admin::ProvincesControllerTest < ActionController::TestCase
  setup do
    @admin_province = admin_provinces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provinces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_province" do
    assert_difference('Admin::Province.count') do
      post :create, admin_province: { edit: @admin_province.edit, index: @admin_province.index, show: @admin_province.show, update: @admin_province.update }
    end

    assert_redirected_to admin_province_path(assigns(:admin_province))
  end

  test "should show admin_province" do
    get :show, id: @admin_province
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_province
    assert_response :success
  end

  test "should update admin_province" do
    patch :update, id: @admin_province, admin_province: { edit: @admin_province.edit, index: @admin_province.index, show: @admin_province.show, update: @admin_province.update }
    assert_redirected_to admin_province_path(assigns(:admin_province))
  end

  test "should destroy admin_province" do
    assert_difference('Admin::Province.count', -1) do
      delete :destroy, id: @admin_province
    end

    assert_redirected_to admin_provinces_path
  end
end
