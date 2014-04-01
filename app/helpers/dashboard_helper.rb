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
    total = @total_facturas + @total_hospitalizacion + @total_transferencia
    @porcentaje_ventanilla = regla_de_tres(@total_facturas, total)
    @porcentaje_hospitalizacion = regla_de_tres(@total_hospitalizacion, total)
    @porcentaje_transferencia = regla_de_tres(@total_transferencia, total)
  end

  def caja_dia(tiempo)
    @facturas = Factura.where(:created_at => tiempo, :anulada => false)
    values = @facturas.select('SUM(total) total_ventanilla , SUM(subtotal_12) as total_sub_0, SUM(iva) as total_iva')
    values = values.collect { |p| [p.total_ventanilla,p.total_sub_0, p.total_iva]}
    values = nil_0(values)
    @ventanilla_cantidad = @facturas.count()
    @ventanilla_total = values[0]
    @ventanilla_subtotal = values[1]
    @ventanilla_iva = values[2]
  end

  def caja_mes(tiempo)
    caja_dia(tiempo)
    @hospitalizacion = Hospitalizacion.where(:created_at => tiempo)
    hospitalizacion = @hospitalizacion.select('SUM(total) total_hospitalizacion , SUM(subtotal) as total_sub, SUM(iva) as total_iva')
    @hospitalizacion_cantidad = @hospitalizacion.count()
    hospitalizacion = hospitalizacion.collect { |p| [p.total_hospitalizacion,p.total_sub, p.total_iva]}
    hospitalizacion = nil_0(hospitalizacion)
    @hospitalizacion_total = hospitalizacion[0]
    @hospitalizacion_subtotal = hospitalizacion[1]
    @hospitalizacion_iva = hospitalizacion[2]
    @traspaso = Traspaso.where(:created_at => tiempo)
    @transferencia_cantidad = @traspaso.count()   
    traspaso = @traspaso.select('SUM(total) total_traspaso , SUM(subtotal) as total_sub, SUM(iva) as total_iva')
    traspaso = traspaso.collect { |p| [p.total_traspaso,p.total_sub, p.total_iva]}
    traspaso = nil_0(traspaso)
    @transferencia_total = traspaso[0]
    @transferencia_subtotal = traspaso[1]
    @transferencia_iva = traspaso[2]
    @comprobantes_cantidad = @ventanilla_cantidad + @hospitalizacion_cantidad + @transferencia_cantidad
    @comprobantes_subtotal = @ventanilla_subtotal + @hospitalizacion_subtotal + @transferencia_subtotal
    @comprobantes_iva = @ventanilla_iva + @hospitalizacion_iva + @transferencia_iva
    @comprobantes_total = @ventanilla_total + @hospitalizacion_total + @transferencia_iva
  end

  def query_reports(tiempo)
    caja_mes(tiempo)
    @compra = FacturaCompra.where(:created_at => tiempo)
    compra = @compra.select('SUM(total) total_compra , SUM(subtotal_0) as total_sub, SUM(iva) as total_iva')
    @compra_cantidad = @compra.count()
    compra = compra.collect { |p| [p.total_compra,p.total_sub, p.total_iva]}
    compra = nil_0(compra)
    @compra_total = compra[0]
    @compra_subtotal = compra[1]
    @compra_iva = compra[2]
  end

  def liquidacion(tiempo)
    query_reports(tiempo)
  end
end
