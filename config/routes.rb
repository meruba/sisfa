Sisfa::Application.routes.draw do
get "dashboard/index"
get "clientes/autocomplete"
get "productos/autocomplete"
get "proveedors/autocomplete"
get "facturas/ventanilla"
get "facturas/hospitalizacion"
get "facturas/consulta_externa"
get "facturas/venta"
get "facturas/compra"
get "facturas/index_compra"
get "facturas/index_anulada"
get "dashboard/caducados"
# post "dashboard/generar_reporte"
get "dashboard/cierre_de_caja_dia"
get "dashboard/cierre_de_caja_mes"
get "dashboard/reportes_cierre_caja"
get "dashboard/estadisticas_dia"
get "dashboard/estadisticas_mes"
# match "dashboard/cierre_de_caja_dia" => "dashboard#cierre_de_caja_dia", via: [:get, :post]
match "dashboard/generar_reporte" => "dashboard#generar_reporte", via: [:get, :post]
get "login"   => "user_sessions#new",        :as => "login"
get "logout"  => "user_sessions#destroy",    :as => "logout"
  
  resources :user_sessions
  resources :users do
    member do
      post "suspender"
    end
  end
  resources :personas
  resources :clientes
  resources :proveedors
  resources :registros
  resources :productos do
    resources :kardexes, :as => "kardex"
  end
  resources :facturas do
    member do
      post "anular"
    end
  end
    #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  resources :item_facturas
  resources :proformas
  resources :item_proformas

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'dashboard#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
