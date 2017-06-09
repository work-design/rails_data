Rails.application.routes.draw do

  scope module: 'the_data' do
    resources :data_lists do
      put :update_publish, on: :member
      resources :table_lists do
        get 'import' => :new_import, on: :collection
        post 'import' => :create_import, on: :collection
        get :row, on: :member
        patch :run, on: :member
        patch :migrate, on: :member
      end
    end
  end

end
