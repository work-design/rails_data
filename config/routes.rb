Rails.application.routes.draw do
  scope module: 'one_report' do

    resources :report_lists do
      get :reportable, on: :collection
      put :update_publish, on: :member
      resources :table_lists do
        get :row, on: :member
      end
    end

    resources :combines do
      get :table_lists, on: :member
    end

  end
end
