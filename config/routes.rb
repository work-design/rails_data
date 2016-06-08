Rails.application.routes.draw do

  scope module: 'the_data' do
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
