require 'test_helper'

class TheData::TableListsControllerTest < ActionController::TestCase
  setup do
    @table_list = create :table_list
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:table_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create table_list" do
    assert_difference('TableList.count') do
      post :create, table_list: {  }
    end

    assert_redirected_to table_list_path(assigns(:table_list))
  end

  test "should show table_list" do
    get :show, id: @table_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @table_list
    assert_response :success
  end

  test "should update table_list" do
    patch :update, id: @table_list, table_list: {  }
    assert_redirected_to table_list_path(assigns(:table_list))
  end

  test "should destroy table_list" do
    assert_difference('TableList.count', -1) do
      delete :destroy, id: @table_list
    end

    assert_redirected_to table_lists_path
  end
end
