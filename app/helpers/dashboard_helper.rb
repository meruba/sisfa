module DashboardHelper
	def regla_de_tres (total_tipo_factura, total_facturas)
    if total_facturas == 0
      porcentaje = 0        
    else
      porcentaje = (100 * total_tipo_factura)/total_facturas
    end
    return porcentaje
  end

  def cantidad_facturas(facturas, tipo_factura)
    cantidad = 0
    facturas.each do |value, key|
      key.each do |factura|
        if factura.tipo_venta == tipo_factura
          cantidad += 1
        end
      end
    end
    return cantidad
  end

  def valor_total_por_facturas(facturas, tipo_factura)
    total = 0
    facturas.each do |value, key|
      key.each do |factura|
        if factura.tipo_venta == tipo_factura
          total += factura.total
        end
      end
    end
    return '%.2f' %total
  end

  def valor_total_facturas(facturas)
    total = 0
    facturas.each do |value, key|
      key.each do |factura|
          total += factura.total
      end
    end
    return '%.2f' %total
  end

  def sumar_impuesto (todas_facturas, tipo_factura, tipo_impuesto)
    impuesto = tipo_impuesto
    sumar = 0
    todas_facturas.each do |value, key|
      key.each do |factura|
        if factura.tipo_venta == tipo_factura
          case impuesto
          when 'iva'
            sumar += factura.iva
          when 'subtotal_0'
            sumar += factura.subtotal_0
          when 'subtotal_12'
            sumar += factura.subtotal_12
          when 'descuento'
            sumar += factura.descuento
          end
          sumar
        end
      end
    end
    return sumar
  end
end
