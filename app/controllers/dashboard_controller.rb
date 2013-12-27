class DashboardController < ApplicationController
  before_filter :require_login
  def index
    #estas son las consultas referentes a hoy... no olvides
    @facturashoy = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day)
    @facturasventanilla = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day, :tipo => "ventanilla")
    @facturashospitalizacion = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day, :tipo => "hospitalizacion")
    @facturaconsultaexterna = Factura.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day, :tipo => "consulta_externa")
  end
end

