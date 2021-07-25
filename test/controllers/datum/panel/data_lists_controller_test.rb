require 'test_helper'
class Datum::Admin::DataListsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @data_list = create :data_list
  end

  test 'index ok' do
    get admin
    assert_response :success
    assert_not_nil assigns(:data_lists)
  end

  test 'new ok' do
    get :new
    assert_response :success
  end

  test 'create data_list' do
    assert_difference('TableList.count') do
      post :create, data_list: {  }
    end

    assert_response :success
  end

  test 'show data_list' do
    get :show, id: @data_list
    assert_response :success
  end

  test 'edit' do
    get :edit, id: @data_list, xhr: true
    assert_response :success
  end

  test 'update data_list' do
    patch :update, id: @data_list, data_list: {  }
    assert_response :success
  end

  test 'destroy data_list' do
    assert_difference('TableList.count', -1) do
      delete :destroy, id: @data_list
    end

    assert_response :success
  end
end
