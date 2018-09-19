require 'test_helper'
class RailsData::ReportListsControllerTest < ActionController::TestCase

  setup do
    @report_list = create :report_list
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_list" do
    assert_difference('TableList.count') do
      post :create, report_list: {  }
    end

    assert_redirected_to report_list_path(assigns(:report_list))
  end

  test "should show report_list" do
    get :show, id: @report_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report_list
    assert_response :success
  end

  test "should update report_list" do
    patch :update, id: @report_list, report_list: {  }
    assert_redirected_to report_list_path(assigns(:report_list))
  end

  test "should destroy report_list" do
    assert_difference('TableList.count', -1) do
      delete :destroy, id: @report_list
    end

    assert_redirected_to report_lists_path
  end
end
