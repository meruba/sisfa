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
    @totaldia = @total_ventanilla + @total_hospitalizacion
    num_comprobantes = @cantidad_ventanilla + @cantidad_hospitalizacion
    @porcentajedia_ventanilla = regla_de_tres(@cantidad_ventanilla, num_comprobantes)
    @porcentajedia_hospitalizacion = regla_de_tres(@cantidad_hospitalizacion, num_comprobantes)
  end

  def estadisticas_mes
    # porcentaje de ventas mes  
    estadisticas(nil, Time.now)
    estadisticas_hospitalizados(nil, Time.now)
    @totalmes = @total_ventanilla + @total_hospitalizacion
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
      @search = consulta_facturas(@start_date.to_time.beginning_of_day..@end_date.to_time.end_of_day, "compra")
      @cantidad_compra = cantidad_comprobantes(@search)
      @total_compra = valor_total_comprobantes(@search)
    when "venta"
      @search = consulta_facturas(@start_date.to_time.beginning_of_day..@end_date.to_time.end_of_day, "venta")
      @cantidad_ventanilla = cantidad_comprobantes(@search)
      @total_ventanilla = valor_total_comprobantes(@search)
    when "hospitalizacion"
      @search = Hospitalizacion.where(:created_at => @start_date.to_time.beginning_of_day..@end_date.to_time.end_of_day)
    when "transferencia"
      @search = Traspaso.where(:created_at => @start_date.to_time.beginning_of_day..@end_date.to_time.end_of_day)
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/generar_reporte.html.erb", :orientation => 'Landscape'
      end
      format.js
    end
  end

  def reportes_cierre_caja_diario
    cierres_de_caja("dia", params[:fecha].to_time )
    if @total_ventanilla == 0
      render :template => "results/not_result"
    else
      render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
    end
  end

  def reportes_cierre_caja_mensual
    cierres_de_caja("mes", params[:fecha].to_time)
    if @total_ventanilla == 0
      render :template => "results/not_result"
    else
      render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
    end
  end

  def liquidaciones
    @fecha = params[:fecha]
    unless @fecha.to_time > Time.now
      cierres_de_caja("mes", @fecha.to_time)
      @anuladas_ventanilla = facturas_anuladas(params[:fecha].to_time).count()
      # transferencias
      transferencias = transferencias(@fecha)
      @numero_transferencias = transferencias.count()
      @transferencias_subtotal = transferencias.sum(:subtotal)
      @transferencias_iva = transferencias.sum(:iva)
      @total_transferencias = transferencias.sum(:total)
      # valores de ventas y transferencias
      @subtotal_ventas = @hospitalizacion_subtotal + @ventanilla_subtotal + @transferencias_subtotal
      @iva_ventas = @ventanilla_iva + @hospitalizacion_iva + @transferencias_iva
      @total_ventas = @subtotal_ventas + @iva_ventas
      #valores factura de compra
      @compras = facturas_compra(@fecha.to_time)
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "liquidaciones", :locals => { :fecha => @fecha }, :layout => 'report.html', :template => "dashboard/liquidaciones.html.erb", :orientation => 'Landscape'
        end
      end
    else
      render :template => "results/not_result"
    end
  end

  def cierre_de_caja_dia
    cierres_de_caja("dia", Time.now)
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
      end
    end
  end

  def cierre_de_caja_mes
    cierres_de_caja("mes", Time.now)
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
      end
    end
  end

  def caducados
    @caducados = IngresoProducto.where(:fecha_caducidad =>Time.now.end_of_day..Time.now.months_since(4)).where("cantidad != '0'")
    @hoy = Date.today
    respond_to do |format|
      # format.json { render json: ProductosDatatable.new(view_context, "caducados") }
      format.html
      format.js
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
    @total_ventanilla = valor_total_comprobantes(@facturas)
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
    @total_hospitalizacion = valor_total_comprobantes(@hospitalizados)
  end

  def cierres_de_caja(periodo, fecha)
    if periodo == "dia"
      estadisticas(fecha, nil)
      @ventanilla_subtotal = sumar_impuesto(@facturas, "subtotal_0")
      @ventanilla_iva = sumar_impuesto(@facturas, "iva")
    else
      estadisticas(nil, fecha)
      estadisticas_hospitalizados(nil, fecha)
      @ventanilla_subtotal = sumar_impuesto(@facturas, "subtotal_0")
      @hospitalizacion_subtotal = sumar_impuesto(@hospitalizados, "subtotal")
      @total_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal
      @ventanilla_iva = sumar_impuesto(@facturas, "iva")
      @hospitalizacion_iva = sumar_impuesto(@hospitalizados, "iva")
      @total_iva = @ventanilla_iva + @hospitalizacion_iva
      @num_comprobantes = @cantidad_ventanilla + @cantidad_hospitalizacion
      @totaldia = @total_ventanilla + @total_hospitalizacion
    end
  end

  def consulta_facturas(fecha, tipo)
    case current_user.rol
    when Rol.administrador
      todasfacturas = Factura.where(:created_at => fecha, :tipo => tipo, :anulada => false)
    when Rol.vendedor
      todasfacturas = Factura.where(:created_at => fecha, :user_id => current_user.id, :anulada => false)
    end
    return :json => todasfacturas
  end

  def consulta_hospitalizacion(fecha)
    case current_user.rol
    when Rol.administrador
      hospitalizados = Hospitalizacion.where(:created_at => fecha)
    when Rol.vendedor
      hospitalizados = Hospitalizacion.where(:created_at => fecha, :user_id => current_user.id)
    end
    return :json => hospitalizados
  end

  def facturas_anuladas(fecha)
    facturas = Factura.where(:created_at => fecha.beginning_of_month..fecha.end_of_month).where(:anulada => true)
  end

  def transferencias(fecha)
    fecha = fecha.to_time
    traspasos = Traspaso.where(:created_at => fecha.beginning_of_month..fecha.end_of_month)
  end

  def facturas_compra(fecha)
    facturas = FacturaCompra.where(:created_at => fecha.beginning_of_month..fecha.end_of_month)
  end
end
