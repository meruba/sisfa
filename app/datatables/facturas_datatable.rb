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
    case @place
    when "venta"
    facturas.map do |factura|
      [
        (factura.cliente.nombre),
        (factura.numero),
        (factura.total),
        (factura.user.username),
        (link_to '', factura, :remote => true,  :rel => 'tooltip', 'data-toggle' =>  "modal", 'data-target' => '#myModal', :title => 'Mostrar', class: "ttip fa fa-eye btn btn-info") + " " + 
        (link_to '', @view.anular_factura_path(factura), :remote => true, :rel => "tooltip",  'data-toggle' =>  "modal", 'data-target' => '#myModal', :title => 'Anular',  class: "ttip fa fa-thumbs-down btn btn-danger")
        # (link_to 'Create PDF',factura, :format => :pdf)
      ]
    end
    when "anulada"
    facturas.map do |factura|
      [
        (factura.cliente.nombre),
        (factura.numero),
        (factura.razon_anulada),
        (factura.total),
        (factura.user.username),
        (link_to '', factura, :remote => true, :rel => 'tooltip','data-toggle' =>  "modal", 'data-target' => '#myModal', :title => 'Mostrar', class: "ttip fa fa-eye btn btn-info")
      ]
    end 
    when "compra"
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
  end

  def facturas
    @facturas ||= fetch_facturas
  end

  def fetch_facturas
    case @place
    when "compra"  
      facturas = Factura.includes(:proveedor).where(:tipo => "compra").order("#{sort_column} #{sort_direction}").references(:proveedor)
    when "anulada"
      facturas = Factura.includes(:cliente).where(:anulada => true).order("#{sort_column} #{sort_direction}").references(:cliente)
    when "venta"
      facturas = Factura.includes(:cliente).where("tipo = 'venta' and anulada = false").order("#{sort_column} #{sort_direction}").references(:cliente)
    end
    facturas = facturas.page(page).per_page(per_page)
    if params[:sSearch].present?
      case @place
      when "compra"
        facturas = facturas.includes(:proveedor).where("proveedors.nombre_o_razon_social like :search or tipo like :search or numero like :search", search: "%#{params[:sSearch]}%").references(:proveedor)
      when "anulada"
        facturas = facturas.includes(:cliente).where("clientes.nombre like :search or tipo like :search or numero like :search", search: "%#{params[:sSearch]}%").references(:cliente)
      when "venta"
        facturas = facturas.includes(:cliente).where("clientes.nombre like :search or tipo like :search or numero like :search", search: "%#{params[:sSearch]}%").references(:cliente)
      end
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
    columns = %w[cliente_id numero tipo user_id total]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end