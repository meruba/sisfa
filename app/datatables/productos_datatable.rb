class ProductosDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Producto.count,
      iTotalDisplayRecords: productos.total_entries,
      aaData: data
    }
  end

private

  def data
    productos.map do |producto|
      [
        (producto.nombre),
        #(producto.nombre_generico),
        (producto.cantidad_disponible),
        (producto.precio_a),
        (producto.codigo),
        (producto.categoria),
        (link_to '', @view.edit_producto_path(producto), {:remote => true, :rel => 'tooltip', :title => 'Editar', 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip fa fa-pencil btn btn-warning"}) + " " + (link_to '', producto, :remote => true, :rel => 'tooltip', :title=> 'Mostrar','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip fa fa-eye btn btn-info mostrar"),
        #(producto.casa_comercial)
      ]
    end 
  end

  def productos
    @productos ||= fetch_productos
  end

  def fetch_productos
    productos = Producto.order("#{sort_column} #{sort_direction}")
    productos = productos.page(page).per_page(per_page)
    if params[:sSearch].present?
      productos = productos.where("nombre like :search or codigo like :search or categoria like :search", search: "%#{params[:sSearch]}%")
    end
    productos
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[nombre cantidad_disponible precio_a codigo categoria ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end