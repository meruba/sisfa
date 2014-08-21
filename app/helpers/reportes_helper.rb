module ReportesHelper
  def query_reports(tiempo, tipo)
    case tipo
    when "ventanilla"
      @facturas = Factura.where(:created_at => tiempo, :anulada => false)
      @facturas_cantidad = @facturas.count()
      @facturas_subtotal_12= @facturas.sum(:subtotal_12)
      @facturas_subtotal_0 = @facturas.sum(:subtotal_0)
      @facturas_iva = @facturas.sum(:iva)
      @facturas_total = @facturas.sum(:total)
    when "hospitalizacion"
      @hospitalizacion = Hospitalizacion.includes(:hospitalizacion_registro).where(:created_at => tiempo).references(:hospitalizacion_registro)
      @hospitalizacion_cantidad = @hospitalizacion.count()
      @hospitalizacion_subtotal_12 = @hospitalizacion.sum(:subtotal_12)
      @hospitalizacion_subtotal = @hospitalizacion.sum(:subtotal)
      @hospitalizacion_iva = @hospitalizacion.sum(:iva)
      @hospitalizacion_total = @hospitalizacion.sum(:total)
    when "transferencia"
      @traspaso = Traspaso.where(:created_at => tiempo)
      @transferencia_cantidad = @traspaso.count()
      @transferencia_subtotal_12 = @traspaso.sum(:subtotal_12)
      @transferencia_subtotal = @traspaso.sum(:subtotal)
      @transferencia_iva = @traspaso.sum(:iva)
      @transferencia_total = @traspaso.sum(:total)
    when "compra"    
      @compra = FacturaCompra.where(:created_at => tiempo)
      @compra_cantidad = @compra.count() 
      @compra_subtotal_12 = @compra.sum(:subtotal_12)
      @compra_subtotal_0 = @compra.sum(:subtotal_0)
      @compra_iva = @compra.sum(:iva)
      @compra_total = @compra.sum(:total)
    end
    end
  end