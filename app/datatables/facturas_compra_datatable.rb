class FacturasCompraDatatable
  delegate :params,:link_to, :h, to: :@view

  def initialize(view)
    @view = view
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
        (factura.proveedor.nombre_o_razon_social),
        (factura.numero),
        (factura.total),
        (factura.user.username),
        (link_to '', factura, :remote => true, :rel =>'tooltip', 'data-toggle' =>  "modal", 'data-target' => '#myModal', :title => 'Mostar', class: "ttip fa fa-eye btn btn-info")
        # (link_to 'delete', factura, method: :delete, class: "cancel_button")
      ]
    end
  end

  def facturas
    @facturas ||= fetch_facturas
  end

  def fetch_facturas
    facturas = FacturaCompra.order("#{sort_column} #{sort_direction}")
    facturas = facturas.page(page).per_page(per_page)
    if params[:sSearch].present?
      facturas = facturas.includes(:proveedor).where("proveedors.nombre_o_razon_social like :search or numero like :search", search: "%#{params[:sSearch]}%").references(:proveedor)
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
    columns = %w[proveedor_id numero tipo user_id total]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end