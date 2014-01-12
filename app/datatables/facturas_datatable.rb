class FacturasDatatable
  delegate :params,:link_to, :h, to: :@view

  def initialize(view, place)
    @view = view
    @place = place
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: facturas.count,
      iTotalDisplayRecords: facturas.total_entries,
      aaData: data
    }
  end

  private

  def data
    facturas.map do |factura|
      [
        (factura.cliente.nombre),
        (factura.numero),
        (factura.tipo),
        (factura.total),
        (link_to '', factura, :remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "fa fa-eye btn btn-info")
        # (link_to 'Mostrar', @view.show(factura), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "btn btn-warning"})
        # (link_to '', @view.show_factura_path(factura), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "btn btn-warning"})
        # (link_to 'delete', factura, method: :delete, class: "cancel_button")
      ]
    end 
  end

  def facturas
    @facturas ||= fetch_facturas
  end

  def fetch_facturas
    case @place
    when "compra"
      facturas = Factura.where(:tipo => "compra").order("#{sort_column} #{sort_direction}")
    when "anulada"
      facturas = Factura.where(:anulada => true).order("#{sort_column} #{sort_direction}")
    when "venta"
      facturas = Factura.where("tipo != 'compra'").order("#{sort_column} #{sort_direction}")
    end
    facturas = facturas.page(page).per_page(per_page)
    if params[:sSearch].present?
      facturas = facturas.where("tipo like :search or numero like :search", search: "%#{params[:sSearch]}%")
    end
    facturas
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[cliente_id numero tipo total]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end