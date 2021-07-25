require 'test_helper'
module Datum
  class Panel::DataListsControllerTest < ActionDispatch::IntegrationTest

    setup do
      @data_list = datum_data_lists(:one)
    end

    test 'index ok' do
      get url_for(controller: 'datum/panel/data_lists')
      assert_response :success
    end

    test 'new ok' do
      get url_for(controller: 'datum/panel/data_lists', action: 'new')
      assert_response :success
    end

    test 'create ok' do
      assert_difference('Datum::DataList.count') do
        post(
          url_for(controller: 'datum/panel/data_lists', action: 'create'),
          params: { data_list: {  } },
          as: :turbo_stream
        )
      end

      assert_response :success
    end

    test 'show ok' do
      get url_for(controller: 'datum/panel/data_lists', action: 'show', id: @data_list.id)
      assert_response :success
    end

    test 'edit ok' do
      get url_for(controller: 'datum/panel/data_lists', action: 'edit', id: @data_list.id)
      assert_response :success
    end

    test 'update ok' do
      patch(
        url_for(controller: 'datum/panel/data_lists', action: 'update', id: @data_list.id),
        params: { data_list: { comment: 'x' } },
        as: :turbo_stream
      )

      @data_list.reload
      assert_equal 'x', @data_list.comment
      assert_response :success
    end

    test 'destroy ok' do
      assert_difference('Datum::DataList.count', -1) do
        delete url_for(controller: 'datum/panel/data_lists', action: 'destroy', id: @data_list.id), as: :turbo_stream
      end

      assert_response :success
    end
  end
end
