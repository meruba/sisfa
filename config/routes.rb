Sisfa::Application.routes.draw do
  resources :emisors

get "dashboard/index"
get "clientes/autocomplete"
get "productos/autocomplete"
get "historia_clinicas/autocomplete"
get "hospitalizacion_registros/autocomplete"
get "productos/autocomplete_producto_compra"
get "productos/inventario"
get "productos/caducado"
get "productos/alerta"
get "proveedors/autocomplete"
get "facturas/index_compra"
get "facturas/index_anulada"
get "dashboard/liquidaciones"
get "dashboard/generar_reporte"
get "dashboard/cierre_de_caja_dia"
get "dashboard/cierre_de_caja_mes"
get "dashboard/reportes_cierre_caja_diario"
get "dashboard/reportes_cierre_caja_mensual"
get "dashboard/estadisticas_dia"
get "dashboard/estadisticas_mes"
get "hospitalizacion_registros/reporte"
get "pacientes/autocomplete"
get "pacientes/civil"
get "pacientes/militar"
get "pacientes/familiar"
get "doctors/autocomplete"
get "doctors/imprimir_listado"
get "doctors/dashboard"
get "jornada_morbilidads/reporte"
get "enfermedads/autocomplete"
get "jornada_preventivas/reporte"
get "emergencia_parte_mensuals/reporte"
get "dashboard_hospital/index"
get "dashboard_hospital/estadisticas_hoy"
get "dashboard_hospital/estadisticas_mes"
get "turnos/hoy"
get "turnos/manana"
get "dashboard_hospital/ingresados"
get "dashboard_enfermeria/index"
get "panel_control_admin/index"

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
  resources :pacientes do
    resources :hospitalizacion_registros, :only => [:new, :create, :edit, :update]
    resources :emergencia_registros
    get "view_edit"
    get "print_historia"
  end

  resources :turnos do
    resources :consulta_externa_morbilidads, :only => [:new, :create]
    resources :consulta_externa_preventivas, :only => [:new, :create]
  end

  resources :clientes
  resources :consulta_externa_morbilidads, :only => [:show]
  resources :proveedors
  resources :hospitalizacion_registros do
    resources :asignacion_camas
  end
  resources :nota_enfermeras, :only => [:show]
  resources :item_nota_enfermeras
  resources :entrega_turnos do
    get "view_create_item"
    resources :item_entrega_turnos 
  end
  resources :signo_vitals, :only => [:show]
  resources :item_signo_vitals
  resources :item_facturas
  resources :item_proformas
  resources :traspasos
  resources :item_traspasos
  resources :cuartos
  resources :camas
  resources :hospitalizacions do
    member do
      post "dar_de_alta"
    end
  end
  resources :item_hospitalizacions do
    member do
      post "despachar"
    end
  end
  resources :factura_compras
  resources :product_imports
  resources :cliente_imports
  resources :informacion_adicional_pacientes, :only => [:edit, :update]
  resources :revisions
  resources :doctors do
    resources :jornada_morbilidads
    resources :jornada_preventivas
    member do
      get "pacientes_emergencia"
      get "turnos_dia"
      get "turnos_manana"
      post "suspender"
    end
  end
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
