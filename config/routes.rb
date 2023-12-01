Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    namespace :datum, defaults: { business: 'datum' } do
      namespace :admin, defaults: { namespace: 'admin' } do
        resources :data_lists, only: [] do
          resources :table_lists do
            collection do
              match :find, via: [:get, :post]
            end
            member do
              match :chart, via: [:get, :post]
            end
          end
        end
      end
      namespace :panel, defaults: { namespace: 'panel' } do
        resources :data_lists do
          collection do
            post :sync
          end
          member do
            put :update_publish
            patch :rebuild
          end
          resources :table_lists do
            collection do
              get :direct
              get 'import' => :new_import
              post 'import' => :create_import
            end
            member do
              match :chart, via: [:get, :post]
              get :row
              get :xlsx
              get :pdf, defaults: { format: 'pdf' }
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
            collection do
              match :find, via: [:get, :post]
            end
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
  end
end
