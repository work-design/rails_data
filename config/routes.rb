Rails.application.routes.draw do

  scope module: 'datum/admin' do
    resources :data_lists do
      member do
        put :update_publish
        patch :rebuild
      end
      resources :table_lists do
        collection do
          get :find
          get :direct
          get 'import' => :new_import
          post 'import' => :create_import
        end
        member do
          get :chart
          get :row
          get :xlsx
          patch :run
          patch :migrate
        end
      end
    end

    resources :data_records do
      collection do
        get :add_item
        get :remove_item
      end
      member do
        patch :rebuild
      end
      resources :record_lists do
        get :find, on: :collection
        member do
          get :row
          patch :run
          get 'columns' => :edit_columns
          patch 'columns' => :update_columns
        end
      end
    end
  end

end
