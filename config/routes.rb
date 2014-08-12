Sisfa::Application.routes.draw do
  resources :emisors
  get "clientes/autocomplete"
  get "productos/autocomplete"
  get "hospitalizacion_registros/autocomplete"
  get "productos/autocomplete_producto_compra"
  get "productos/inventario"
  get "productos/caducado"
  get "productos/alerta"
  get "proveedors/autocomplete"
  get "facturas/index_compra"
  get "facturas/index_anulada"
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
  get "panel_aplication/index"
  get "traspasos/index_anulada"
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
  resources :condicions, :only => [:show]
  resources :clientes
  resources :consulta_externa_morbilidads, :only => [:show]
  resources :proveedors
  resources :hospitalizacion_registros do
    resources :asignacion_camas
    member do
      post "dar_alta_enfermeria"
    end
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
  resources :traspasos do
    member do
      get "anular"
      post "anulado"
    end
  end
  resources :item_traspasos
  resources :cuartos
  resources :camas
  resources :hospitalizacions, :only => [:index, :show] do
    get "show_pedido"
    get 'pedidos', :on => :collection
  end
  resources :item_hospitalizacions do
    member do
      post "despachar"
      get "anular"
      post "anulado"
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
  resources :cierre_cajas do
    member do
      get "print_and_close"
    end
  end
  resources :reportes
  root 'panel_aplication#index'
end
