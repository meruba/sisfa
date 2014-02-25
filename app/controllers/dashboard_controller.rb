class DashboardController < ApplicationController
  before_filter :require_login
  include DashboardHelper
  
  def index    
    estadisticas_dia
  end

  def estadisticas_dia
    # porcentaje de ventas dia
    estadisticas(Time.now, nil)
    estadisticas_hospitalizados(Time.now, nil)
    @totaldia = @totalfacturas + @totalhospitalizacion
    num_comprobantes = @cantidad_ventanilla + @cantidad_hospitalizacion
    @porcentajedia_ventanilla = regla_de_tres(@cantidad_ventanilla, num_comprobantes)
    @porcentajedia_hospitalizacion = regla_de_tres(@cantidad_hospitalizacion, num_comprobantes)
  end

  def estadisticas_mes
    # porcentaje de ventas mes  
    estadisticas(nil, Time.now)
    estadisticas_hospitalizados(Time.now, nil)
    @totalmes = @totalfacturas + @totalhospitalizacion
    num_comprobantes = @cantidad_ventanilla + @cantidad_hospitalizacion
    @porcentajemes_ventanilla = regla_de_tres(@cantidad_ventanilla, num_comprobantes)
    @porcentajemes_hospitalizacion = regla_de_tres(@cantidad_hospitalizacion, num_comprobantes)
  end

  def generar_reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo_factura]
    case @tipo_factura
    when "compra"
      @search = Factura.where(:fecha_de_emision => @start_date.to_time.beginning_of_day..@start_date.to_time.end_of_day, :tipo => "compra")
    when "venta"
      @search = Factura.where(:fecha_de_emision => params[:fecha_inicial]..params[:fecha_final], :tipo => "venta", :anulada => false)
    when "hospitalizacion"
      @search = Hospitalizacion.where(:fecha_emision => params[:fecha_inicial]..params[:fecha_final])      
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
    @fecha = params[:fecha]
    estadisticas(nil, @fecha.to_time)
    # ventas ventanilla
    @ventanilla_subtotal = sumar_impuesto(@facturas, "ventanilla", "subtotal_0")
    @ventanilla_iva = sumar_impuesto(@facturas, "ventanilla", "iva")
    @anuladas_ventanilla = facturas_anuladas(params[:fecha].to_time,"ventanilla").count()
    # ventas hospitalizacion
    @hospitalizacion_subtotal = sumar_impuesto(@facturas, "hospitalizacion", "subtotal_0")
    @hospitalizacion_iva = sumar_impuesto(@facturas, "hospitalizacion", "iva")
    @anuladas_hospitalizacion = facturas_anuladas(params[:fecha].to_time,"hospitalizacion").count()
    # transferencias
    transferencias = transferencias(@fecha)
    @numero_transferencias = transferencias.count()
    @transferencias_subtotal = transferencias.sum(:subtotal)
    @transferencias_iva = transferencias.sum(:iva)
    @total_transferencias = transferencias.sum(:total)
    # valores de ventas y transferencias
    @subtotal_ventas = @hospitalizacion_subtotal + @ventanilla_subtotal + @transferencias_subtotal
    @iva_ventas = @subtotal_ventas * 0.12
    @total_ventas = @subtotal_ventas + @iva_ventas
    #valores factura de compra
    @compras = facturas_compra(@fecha.to_time)
  end

  def cierre_de_caja_dia
    estadisticas(Time.now, nil)
    estadisticas_hospitalizados(Time.now, nil)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@hospitalizados, "subtotal")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "iva")
    @hospitalizacion_iva = sumar_impuesto(@hospitalizados, "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    @num_comprobantes = @cantidad_ventanilla + @cantidad_hospitalizacion
    @totaldia = @totalfacturas + @totalhospitalizacion
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
    estadisticas_hospitalizados(Time.now, nil)
    @ventanilla_subtotal = sumar_impuesto(@facturas, "subtotal_0")
    @hospitalizacion_subtotal = sumar_impuesto(@hospitalizados, "subtotal")
    @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
    @ventanilla_iva = sumar_impuesto(@facturas, "iva")
    @hospitalizacion_iva = sumar_impuesto(@hospitalizados, "iva")
    @total_iva = @ventanilla_iva + @hospitalizacion_iva
    @num_comprobantes = @cantidad_ventanilla + @cantidad_hospitalizacion
    @totaldia = @totalfacturas + @totalhospitalizacion
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

    @cantidad_ventanilla = cantidad_comprobantes(@facturas)
    @total_ventanilla = valor_total_por_comprobantes(@facturas)
    @totalfacturas = valor_total_comprobantes(@facturas)
  end

  def estadisticas_hospitalizados(dia, mes)
    fecha_dia = dia
    fecha_mes = mes
    if dia
      @hospitalizados = consulta_hospitalizacion(fecha_dia.beginning_of_day..fecha_dia.end_of_day)
    else
      @hospitalizados = consulta_hospitalizacion(fecha_mes.beginning_of_month..fecha_mes.end_of_month)
    end

    @cantidad_hospitalizacion = cantidad_comprobantes(@hospitalizados)
    @total_hospitalizacion = valor_total_por_comprobantes(@hospitalizados)
    @totalhospitalizacion = valor_total_comprobantes(@hospitalizados)
  end

  def consulta_facturas(query, tipo)
    case current_user.rol
    when Rol.administrador
      todasfacturas = Factura.where(:created_at => query, :tipo => tipo, :anulada => false)
    when Rol.vendedor
      todasfacturas = Factura.where(:created_at => query, :user_id => current_user.id, :anulada => false)
    end
    return :json => todasfacturas
  end

  def consulta_hospitalizacion(query)
    case current_user.rol
    when Rol.administrador
      hospitalizados = Hospitalizacion.where(:created_at => query)
    when Rol.vendedor
      hospitalizados = Hospitalizacion.where(:created_at => query, :user_id => current_user.id)
    end
    return :json => hospitalizados
  end

  def facturas_anuladas(fecha, tipo)
    facturas = Factura.where(:created_at => fecha.beginning_of_month..fecha.end_of_month).where(:anulada => true)
  end

  def transferencias(fecha)
    fecha = fecha.to_time
    traspasos = Traspaso.where(:created_at => fecha.beginning_of_month..fecha.end_of_month)
  end

  def facturas_compra(fecha)
    facturas = Factura.where(:created_at => fecha.beginning_of_month..fecha.end_of_month).where(:tipo => "compra")
  end
end
