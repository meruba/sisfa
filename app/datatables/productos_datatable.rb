class ProductosDatatable
  delegate :params, :h, to: :@view

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
        (producto.nombre_generico),
        (producto.cantidad_disponible),
        (producto.precio_a),
        (producto.codigo),
        (producto.categoria),
        (producto.casa_comercial)
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
      productos = productos.where("nombre like :search or codigo like :search or email like :search", search: "%#{params[:sSearch]}%")
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
    columns = %w[nombre nombre_generico cantidad_disponible precio codigo categoria casa_comercial]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end