class ClientesDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Cliente.count,
      iTotalDisplayRecords: clientes.total_entries,
      aaData: data
    }
  end

private

  def data
    clientes.map do |cliente|
      [
        (cliente.nombre),
        (cliente.numero_de_identificacion),
        (cliente.direccion),
        (cliente.telefono),        
        (cliente.email),
        (link_to 'Editar', @view.edit_cliente_path(cliente), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "editar_edit"}) + " " + (link_to '', cliente, :remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "fa fa-eye btn btn-info"),
      ]
    end 
  end

  def clientes
    @clientes ||= fetch_clientes
  end

  def fetch_clientes
    clientes = Cliente.order("#{sort_column} #{sort_direction}")
    clientes = clientes.page(page).per_page(per_page)
    if params[:sSearch].present?
      clientes = clientes.where("nombre like :search or numero_de_identificacion like :search or email like :search", search: "%#{params[:sSearch]}%")
    end
    clientes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[nombre numero_de_identificacion telefono direccion email]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end