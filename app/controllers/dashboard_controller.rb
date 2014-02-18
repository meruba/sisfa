class DashboardController < ApplicationController
  before_filter :require_login
  include DashboardHelper
  
  def index    
    estadisticas_dia
  end

  def estadisticas_dia
    # porcentaje de ventas dia
    estadisticas(Time.now, nil)
    @porcentajedia_ventanilla = regla_de_tres(@cantidad_ventanilla, @cantidadfacturas)
    @porcentajedia_hospitalizacion = regla_de_tres(@cantidad_hospitalizacion, @cantidadfacturas)
  end

  def estadisticas_mes
    # porcentaje de ventas mes  
    estadisticas(nil, Time.now)
    @porcentajemes_ventanilla = regla_de_tres(@cantidad_ventanilla, @cantidadfacturas)
    @porcentajemes_hospitalizacion = regla_de_tres(@cantidad_hospitalizacion, @cantidadfacturas)
  end

  def generar_reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo_factura]
    if @tipo_factura == "compra"
      @search = Factura.where(:fecha_de_emision => params[:fecha_inicial]..params[:fecha_final], :tipo => params[:tipo_factura])
    else
      @search = Factura.where(:fecha_de_emision => params[:fecha_inicial]..params[:fecha_final], :tipo_venta => params[:tipo_factura]).where(:anulada => false)
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/generar_reporte", :orientation => 'Landscape'  
      end
      format.js
    end
  end

  def reportes_cierre_caja_diario
    estadisticas(params[:fecha].to_time, nil)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas, "hospitalizacion", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas, "hospitalizacion", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
  end

  def reportes_cierre_caja_mensual
    estadisticas(nil, params[:fecha].to_time)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas, "hospitalizacion", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas, "hospitalizacion", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
  end

  def liquidaciones
    estadisticas(nil, params[:fecha].to_time)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas, "hospitalizacion", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas, "hospitalizacion", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    @anuladas_ventanilla = facturas_anuladas(params[:fecha].to_time,"ventanilla").count()
    @anuladas_hospitalizacion = facturas_anuladas(params[:fecha].to_time,"hospitalizacion").count()
    # ventas ventanilla
    # ventas hospitalizacion
    # transferencias
  end

  def cierre_de_caja_dia
    estadisticas(Time.now, nil)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas, "hospitalizacion", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas, "hospitalizacion", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
      end
    end
  end

  def cierre_de_caja_mes
    estadisticas(nil, Time.now)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "ventanilla", "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@facturas, "hospitalizacion", "subtotal_0")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "ventanilla", "iva")
    @hospitalizacion_iva = sumar_impuesto(@facturas, "hospitalizacion", "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
      end
    end
  end

  def caducados
    respond_to do |format|
      format.json { render json: ProductosDatatable.new(view_context, "caducados") }
    end
    # @caducados = Producto.where(:fecha_de_caducidad =>Time.now.end_of_day..Time.now.months_since(4))    
  end

  private

  def estadisticas(dia, mes)
    fecha_dia = dia
    fecha_mes = mes
    if dia
      @facturas = consulta_facturas(fecha_dia.beginning_of_day..fecha_dia.end_of_day,"venta")
    else
      @facturas = consulta_facturas(fecha_mes.beginning_of_month..fecha_mes.end_of_month,"venta")
    end

    @cantidad_ventanilla = cantidad_facturas(@facturas, "ventanilla")
    @total_ventanilla = valor_total_por_facturas(@facturas, "ventanilla")
    @cantidad_hospitalizacion = cantidad_facturas(@facturas, "hospitalizacion")
    @total_hospitalizacion = valor_total_por_facturas(@facturas, "hospitalizacion")
    @totalfacturas = valor_total_facturas(@facturas)
    @cantidadfacturas = @cantidad_ventanilla + @cantidad_hospitalizacion
  end

  def consulta_facturas(query, tipo)
    todasfacturas = Factura.where(:created_at => query).where(:tipo => tipo).where(:anulada => false)
    return :json => todasfacturas
  end

  def facturas_anuladas(fecha, tipo)
    facturas = Factura.where(:created_at => fecha.beginning_of_month..fecha.end_of_month).where(:tipo_venta => tipo).where(:anulada => true)
  end
end
