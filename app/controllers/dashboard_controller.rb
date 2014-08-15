class DashboardController < ApplicationController
  before_filter :require_login
  before_filter :is_admin_or_vendedor_farmacia

  def liquidaciones
    @fecha = params[:fecha]
    liquidacion(@fecha)
    unless @fecha.to_time > Time.now or @liquidacion.nil?
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "liquidaciones", :locals => { :fecha => @fecha }, :layout => 'report.html', :template => "dashboard/liquidaciones.html.erb"
        end
      end
    else
      render :template => "results/not_result"
    end
  end
end
