Sisfa::Application.routes.draw do
  get "asignar_horarios/new"
  get "configuraciones_fisiatria/index"
  get "reportes_fisiatria/index"
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
  get "reportes/reporte_total"
  get "reportes/liquidaciones"
  get "reportes/cierre_caja_mensual"
  get "reportes/cierre_caja_diario"
  get "turnos/consulta_turnos"
  get "turnos/consulta_resultados"
  #fisiatria
  get "calendario/index"
  get "calendario/next_month"
  get "calendario/prev_month"
  get "calendario/current_month"
  get "item_tratamientos/autocomplete"
  get "resultado_tratamientos/by_day"


  resources :emisors, except: [:show, :destroy, :index] do
    member do
      get 'turnos_otros_dias'
    end
  end
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, except: [:destroy] do
    member do
      post "suspender"
    end
  end
  resources :ingreso_productos, only: [:new, :create] do
    resources :canjes, only: [:new, :create]
  end
  resources :pacientes, except: [:new] do
    resources :hospitalizacion_registros, :only => [:new, :create, :edit, :update]
    resources :emergencia_registros, except: [:destroy, :index]
    get "view_edit"
    get "print_historia"
    get 'reporte', :on => :collection
  end
  resources :turnos, except: [:show] do
    resources :consulta_externa_morbilidads, :only => [:new, :create]
    resources :consulta_externa_preventivas, :only => [:new, :create]
  end
  resources :condicions, :only => [:show]
  resources :clientes
  resources :consulta_externa_morbilidads, :only => [:show]
  resources :proveedors, except: [:destroy]
  resources :hospitalizacion_registros, except: [:destroy] do
    resources :asignacion_camas, only: [:new, :create, :index]
    member do
      post "dar_alta_enfermeria"
    end
  end
  resources :nota_enfermeras, :only => [:show]
  resources :item_nota_enfermeras, only: [:create, :edit, :update]
  resources :entrega_turnos, except: [:edit, :update] do
    get "view_create_item"
    resources :item_entrega_turnos, only: [:create, :destroy]
  end
  resources :signo_vitals, :only => [:show]
  resources :item_signo_vitals, only: [:create, :edit, :update]
  resources :item_facturas
  resources :item_proformas
  resources :traspasos, except: [:edit, :update, :destroy] do
    member do
      get "anular"
      post "anulado"
    end
  end
  resources :item_traspasos
  resources :cuartos, except: [:show, :edit, :update]
  resources :camas, only: [:create, :destroy]
  resources :hospitalizacions, :only => [:index, :show] do
    get "show_pedido"
    get 'pedidos', :on => :collection
  end
  resources :item_hospitalizacions, only: [:create] do
    member do
      post "despachar"
      get "anular"
      post "anulado"
    end
  end
  resources :factura_compras, only: [:show, :new, :create]
  resources :product_imports, only: [:new, :create]
  resources :cliente_imports, only: [:new, :create]
  resources :informacion_adicional_pacientes, :only => [:update]
  resources :revisions
  resources :doctors, except: [:show] do
    resources :jornada_morbilidads, only: [:new, :create, :index]
    resources :jornada_preventivas, only: [:new, :create, :index]
    member do
      post "suspender"
    end
  end
  resources :productos, except: [:destroy] do
    resources :kardexes, :as => "kardex", only: [:index]
  end
  resources :facturas, except: [:edit, :update, :destroy] do
    member do
      get "anular"
      post "anulado"
    end
  end
  resources :proformas, except: [:edit, :update, :destroy] do
    member do
      post "facturar"
    end
  end
  resources :cierre_cajas, only: [:new, :index] do
    member do
      get "print_and_close"
    end
  end
  resources :reportes, only: [:index]
  root 'panel_aplication#index'
  resources :tratamientos
  resources :personals do
    member do
      post "suspender"
    end    
  end
  resources :horarios
  resources :asignar_horarios
end
