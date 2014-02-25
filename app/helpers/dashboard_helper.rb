module DashboardHelper
	def regla_de_tres (comprobante, total_comprobantes)
    if total_comprobantes == 0
      porcentaje = 0        
    else
      porcentaje = (100 * comprobante)/total_comprobantes
    end
    return porcentaje
  end

  def cantidad_comprobantes(comprobante)
    cantidad = 0
    comprobante.each do |value, key|
      key.each do |comprobante|
        cantidad += 1
      end
    end
    return cantidad
  end

  def valor_total_por_comprobantes(comprobante)
    total = 0
    comprobante.each do |value, key|
      key.each do |comprobante|
        total += comprobante.total
      end
    end
    return total
  end

  def valor_total_comprobantes(comprobante)
    total = 0
    comprobante.each do |value, key|
      key.each do |comprobante|
          total += comprobante.total
      end
    end
    return total
  end

  def sumar_impuesto (comprobantes, tipo_impuesto)
    impuesto = tipo_impuesto
    sumar = 0
    comprobantes.each do |value, key|
      key.each do |comprobante|
        case impuesto
        when 'iva'
          sumar += comprobante.iva
        when 'subtotal_0'
          sumar += comprobante.subtotal_0
        when 'subtotal_12'
          sumar += comprobante.subtotal_12
        when 'descuento'
          sumar += comprobante.descuento
        end
        sumar
      end
    end
    return sumar
  end
end
