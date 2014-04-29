class RegistrosDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: registros.count,
      iTotalDisplayRecords: registros.total_entries,
      aaData: data
    }
  end

private

  def data
    registros.map do |registro|
      [
        (registro.nombre_o_razon_social),
        #(registro.direccion),
        (registro.numero_de_identificacion),
        (registro.telefono),        
        (registro.codigo),
        #(registro.representante_legal),
        #(registro.pais),        
        (registro.ciudad),
        #(registro.fax),
        (link_to '', @view.edit_registro_path(registro), {:remote => true, :rel=> 'tooltip', :title => 'Editar', 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip fa fa-pencil btn btn-warning"}) + " " + (link_to '', proveedor, :remote => true, :rel => 'tooltip', :title=> 'Mostrar', 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip fa fa-eye btn btn-info")
      ]
    end 
  end

  def registros
    @registros ||= fetch_registros
  end

  def fetch_registros
    registros = Proveedor.order("#{sort_column} #{sort_direction}")
    registros = registros.page(page).per_page(per_page)
    if params[:sSearch].present?
      registros = registros.where("nombre_o_razon_social like :search or numero_de_identificacion like :search or codigo like :search", search: "%#{params[:sSearch]}%")
    end
    registros
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