Sisfa::Application.routes.draw do
get "dashboard/index"
get "clientes/autocomplete"
get "productos/autocomplete"
get "productos/autocomplete_producto_compra"
get "productos/inventario"
get "proveedors/autocomplete"
get "facturas/index_compra"
get "facturas/index_anulada"
get "dashboard/caducados"
get "dashboard/liquidaciones"
get "dashboard/generar_reporte"
get "dashboard/cierre_de_caja_dia"
get "dashboard/cierre_de_caja_mes"
get "dashboard/reportes_cierre_caja_diario"
get "dashboard/reportes_cierre_caja_mensual"
get "dashboard/estadisticas_dia"
get "dashboard/estadisticas_mes"
# match "dashboard/cierre_de_caja_dia" => "dashboard#cierre_de_caja_dia", via: [:get, :post]
# match "dashboard/generar_reporte" => "dashboard#generar_reporte", via: [:get, :post]
get "login"   => "user_sessions#new",        :as => "login"
get "logout"  => "user_sessions#destroy",    :as => "logout"
  
  resources :user_sessions
  resources :users do
    member do
      post "suspender"
    end
  end
  resources :ingreso_productos do
    resources :canjes
  end
  resources :personas
  resources :clientes
  resources :proveedors
  resources :registros
  resources :item_facturas
  resources :item_proformas
  resources :traspasos
  resources :item_traspasos
  resources :hospitalizacions
  resources :item_hospitalizacions
  resources :factura_compras
  resources :productos do
    resources :kardexes, :as => "kardex"
  end

  resources :facturas do
    member do
      get "anular"
      post "anulado"
    end
  end

  resources :proformas do
    member do
      post "facturar"
    end
  end

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
