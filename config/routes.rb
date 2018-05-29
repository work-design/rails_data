Rails.application.routes.draw do

  scope module: 'the_data_admin' do
    resources :data_lists do
      get :add_item, on: :collection
      get :remove_item, on: :collection
      put :update_publish, on: :member
      patch :rebuild, on: :member
      resources :table_lists do
        get :find, on: :collection
        get 'import' => :new_import, on: :collection
        post 'import' => :create_import, on: :collection
        get :row, on: :member
        patch :run, on: :member
        patch :migrate, on: :member
      end
    end

    resources :data_records do
      get :add_item, on: :collection
      get :remove_item, on: :collection
      patch :rebuild, on: :member
      resources :record_lists do
        get :find, on: :collection
        get :row, on: :member
        patch :run, on: :member
        get 'columns' => :edit_columns, on: :member
        patch 'columns' => :update_columns, on: :member
      end
    end
  end

end
