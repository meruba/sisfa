class ProveedorsDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Proveedor.count,
      iTotalDisplayRecords: proveedors.total_entries,
      aaData: data
    }
  end

private

  def data
    proveedors.map do |proveedor|
      [
        (proveedor.nombre_o_razon_social),
        #(proveedor.direccion),
        (proveedor.numero_de_identificacion),
        (proveedor.telefono),        
        (proveedor.codigo),
        #(proveedor.representante_legal),
        #(proveedor.pais),        
        (proveedor.ciudad),
        #(proveedor.fax),
        (link_to '', @view.edit_proveedor_path(proveedor), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "fa fa-pencil btn btn-warning"}) + " " + (link_to '', proveedor, :remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "fa fa-eye btn btn-info")
      ]
    end 
  end

  def proveedors
    @proveedors ||= fetch_proveedors
  end

  def fetch_proveedors
    proveedors = Proveedor.order("#{sort_column} #{sort_direction}")
    proveedors = proveedors.page(page).per_page(per_page)
    if params[:sSearch].present?
      proveedors = proveedors.where("nombre_o_razon_social like :search or numero_de_identificacion like :search or codigo like :search", search: "%#{params[:sSearch]}%")
    end
    proveedors
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[nombre_o_razon_social numero_de_identificacion telefono codigo ciudad ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end