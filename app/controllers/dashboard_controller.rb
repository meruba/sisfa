class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :suspendido
  include DashboardHelper
  
  def index
    ventas(Time.now.beginning_of_day..Time.zone.now)
  end

  def estadisticas_dia
    ventas(Time.now.beginning_of_day..Time.zone.now)
  end

  def estadisticas_mes
    ventas(Time.now.beginning_of_month..Time.now.end_of_month)
  end

  def generar_reporte
    @start_date = params[:fecha_inicial]
    @end_date = params[:fecha_final]
    @tipo_factura = params[:tipo_factura] 
    respond_to do |format|
      format.html{
        query_reports(params[:fecha_inicial].to_time.beginning_of_day..params[:fecha_final].to_time.end_of_day)
      }
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/generar_reporte.html.erb", :orientation => 'Landscape'
      end
      format.js
    end
  end

  def reportes_cierre_caja_diario
    caja_dia(params[:fecha].to_time.beginning_of_day..params[:fecha].to_time.end_of_day)
    if @ventanilla_cantidad == 0
      render :template => "results/not_result"
    else
      render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
    end
  end

  def reportes_cierre_caja_mensual
    caja_mes(params[:fecha].to_time.beginning_of_month..params[:fecha].to_time.end_of_month)
    if @ventanilla_cantidad == 0
      render :template => "results/not_result"
    else
      render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_mes.html.erb"
    end
  end

  def liquidaciones
    @fecha = params[:fecha]
    unless @fecha.to_time > Time.now
      liquidacion(params[:fecha].to_time.beginning_of_month..params[:fecha].to_time.end_of_month)
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
    caja_dia(Time.now.beginning_of_day..Time.zone.now)
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render :pdf => "reporte", :layout => 'report.html', :template => "dashboard/reportes/pdf_caja_dia.html.erb"
      end
    end
  end

  def cierre_de_caja_mes
    caja_mes(Time.now.beginning_of_month..Time.now.end_of_month)
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
end
