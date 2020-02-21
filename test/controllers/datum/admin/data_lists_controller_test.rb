require 'test_helper'
class Datum::Admin::ReportListsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @report_list = create :report_list
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

  test 'create report_list' do
    assert_difference('TableList.count') do
      post :create, report_list: {  }
    end

    assert_redirected_to report_list_path(assigns(:report_list))
  end

  test 'show report_list' do
    get :show, id: @report_list
    assert_response :success
  end

  test 'edit' do
    get :edit, id: @report_list
    assert_response :success
  end

  test 'update report_list' do
    patch :update, id: @report_list, report_list: {  }
    assert_redirected_to report_list_path(assigns(:report_list))
  end

  test 'destroy report_list' do
    assert_difference('TableList.count', -1) do
      delete :destroy, id: @report_list
    end

    assert_redirected_to report_lists_path
  end
end
