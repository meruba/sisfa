class DashboardController < ApplicationController
  before_filter :require_login
  def index
    #estas son las consultas referentes a hoy... no olvides
    @facturashoy = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day)
    @facturasventanilla = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day, :tipo => "ventanilla")
    @facturashospitalizacion = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day, :tipo => "hospitalizacion")
    @facturaconsultaexterna = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day, :tipo => "consulta_externa")
    @porcentaje_ventanilla = regla_de_tres(@facturasventanilla,@facturashoy)
    @porcentaje_hospitalizacion = regla_de_tres(@facturashospitalizacion,@facturashoy)
    @porcentaje_consultaexterna = regla_de_tres(@facturaconsultaexterna,@facturashoy)
    # raise 'error'
    #estas son las consultas referentes al mes
    @facturasmes = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month)
    @facturasmesventanilla = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month, :tipo => "ventanilla")
    @facturasmeshospitalizacion = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month, :tipo => "hospitalizacion")
    @facturamesconsultaexterna = Factura.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month, :tipo => "consulta_externa")
    #estas son las consultas referentes al año
    @facturasaño = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year)
    @facturasañoventanilla = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year, :tipo => "ventanilla")
    @facturasañohospitalizacion = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year, :tipo => "hospitalizacion")
    @facturasañoconsultaexterna = Factura.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year, :tipo => "consulta_externa")  
  end

private
  def regla_de_tres (tipo_factura, total_facturas)
    total = total_facturas.count
    total_tipo_factura = tipo_factura.count
    porcentaje = (100 * total_tipo_factura)/total
  end
end

