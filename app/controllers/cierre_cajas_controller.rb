class CierreCajasController < ApplicationController
  before_filter :require_login

  def index
    if current_user.cierre_cajas.last and current_user.cierre_cajas.last.is_cerrado == false
      @cierrecaja = current_user.cierre_cajas.last
    else
      redirect_to root_path
      flash[:notice] = "Aún no has facturado nada"
    end
  end

  def new
    @cierrecaja = current_user.cierre_cajas.last
    respond_to do |format|
      format.js
    end
  end

  def print_and_close
    @cierrecaja = CierreCaja.find(params[:id])
    @cierrecaja.is_cerrado = true
    @cierrecaja.save
    render :pdf => "reporte", :layout => 'report.html', :template => "cierre_cajas/pdf.html.erb"
  end
end
