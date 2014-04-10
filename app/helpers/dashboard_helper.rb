module DashboardHelper
	def regla_de_tres (comprobante, total_comprobantes)
    if total_comprobantes == 0
      porcentaje = 0        
    else
      porcentaje = (100.0 * comprobante)/total_comprobantes
    end
    return porcentaje
  end

  def nil_0(array)
    array = array[0]
    array.each_index do |i|
      array[i] ||= 0
    end
  end

  def ventas(tiempo)
    case current_user.rol
    when Rol.administrador
      @total_facturas = Factura.where(:created_at => tiempo, :anulada => false).sum(:total)
      @total_hospitalizacion = Hospitalizacion.where(:created_at => tiempo).sum(:total)
      @total_transferencia = Traspaso.where(:created_at => Time.now.beginning_of_day..Time.zone.now).sum(:total)
    when Rol.vendedor
      @total_facturas = Factura.where(:created_at => Time.now.beginning_of_day..Time.zone.now, :anulada => false, :user_id => current_user.id).sum(:total)
      @total_hospitalizacion = Hospitalizacion.where(:created_at => Time.now.beginning_of_day..Time.zone.now, :user_id => current_user.id).sum(:total)
      @total_transferencia = Traspaso.where(:created_at => Time.now.beginning_of_day..Time.zone.now, :user_id => current_user.id).sum(:total)
    end
    @total = @total_facturas + @total_hospitalizacion + @total_transferencia
    @porcentaje_ventanilla = regla_de_tres(@total_facturas, @total)
    @porcentaje_hospitalizacion = regla_de_tres(@total_hospitalizacion, @total)
    @porcentaje_transferencia = regla_de_tres(@total_transferencia, @total)
  end

  def caja_dia(tiempo)
    case current_user.rol
    when Rol.administrador
      @facturas = Factura.where(:created_at => tiempo, :anulada => false)
    when Rol.vendedor
      @facturas = Factura.where(:created_at => tiempo, :anulada => false, :user_id => current_user.id)
    end
    @primera_factura = @facturas.first
    @ultima_factura = @facturas.last
    values = @facturas.select('SUM(total) total_ventanilla , SUM(subtotal_12) as total_sub_0, SUM(iva) as total_iva')
    values = values.collect { |p| [p.total_ventanilla,p.total_sub_0, p.total_iva]}
    values = nil_0(values)
    @ventanilla_cantidad = @facturas.count()
    @ventanilla_total = values[0]
    @ventanilla_subtotal = values[1]
    @ventanilla_iva = values[2]
  end

  def caja_mes(tiempo)
    @liquidacion = Liquidacion.where(:fecha => tiempo).first
  end

  def query_reports(tiempo, tipo)
    case tipo
    when "ventanilla"
      @facturas = Factura.where(:created_at => tiempo)
      @facturas_cantidad = @facturas.count()
      @facturas_total = @facturas.sum(:total)
    when "hospitalizacion"
      @hospitalizacion = Hospitalizacion.where(:created_at => tiempo)
      @hospitalizacion_cantidad = @hospitalizacion.count()
      @hospitalizacion_total = @hospitalizacion.sum(:total)
    when "transferencia"
      @traspaso = Traspaso.where(:created_at => tiempo)
      @transferencia_cantidad = @traspaso.count()
      @transferencia_total = @traspaso.sum(:total)
    when "compra"    
      @compra = FacturaCompra.where(:created_at => tiempo)
      @compra_cantidad = @compra.count() 
      @compra_total = @compra.sum(:total)
    end
  end

  def liquidacion(tiempo)
    @liquidacion = Liquidacion.where(:fecha => tiempo).first
    # falta agregar inventarios y canje
  end
end
