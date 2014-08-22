module ApplicationHelper
  def form_errors_for(object)
    if object.errors.any?
      content = pluralize object.errors.count, "error", "errores"
      content += link_to "x", "#", :class => "close", :data => {:dismiss => "alert"}
      content += raw "<ul>"
      object.errors.full_messages.each do |msg|
        content += raw content_tag :li, msg
      end
      content += raw "</ul>"
      content_tag :div, id: "error_explanation", :class => "alert alert-error" do
        raw content
      end
    end
  end

  def month_name(date)
    date  = date.to_time
    date.strftime("%B %Y").upcase
  end

  def redondear(number)
    redondeo = number_with_precision(number, precision: 2)
    # numero = "$ " + redondeo
  end

  def regla_de_tres (comprobante, total_comprobantes)
    if total_comprobantes == 0
      porcentaje = 0
    else
      porcentaje = (100.0 * comprobante)/total_comprobantes
    end
    return porcentaje
  end

  def local_date(date, tipo)
    if date.nil? == true
      date = "sin fecha"
    else
      case tipo
      when tipo = "date"
        date = date.strftime("%Y-%m-%d")
      when tipo = "datetime"
        date = date.strftime("%Y-%m-%d | %H:%M:%S")
      when tipo = "time"
        date = date.strftime("%H:%M")
      end
    end
    date
  end

  def human_boolean(boolean)
    boolean ? 'Si' : 'No'
  end
end
