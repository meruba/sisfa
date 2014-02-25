class HospitalizacionsDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Hospitalizacion.count,
      iTotalDisplayRecords: hospitalizacion.total_entries,
      aaData: data
    }
  end

private

  def data
    hospitalizacion.map do |hospitalizado|
      [
        (hospitalizado.numero),
        # (hospitalizado.cliente.nombre),
        (hospitalizado.fecha_emision),
        (hospitalizado.user.username),
        (hospitalizado.subtotal),
        (hospitalizado.iva),
        (hospitalizado.total),
        (link_to '', hospitalizado, :remote => true, :rel=> 'tooltip', :title=>'Mostrar','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip mostrar fa fa-eye btn btn-info")
      ]
    end 
  end

  def hospitalizacion
    @hospitalizacion ||= fetch_hospitalizacion
  end

  def fetch_hospitalizacion
    hospitalizacion = Hospitalizacion.order("#{sort_column} #{sort_direction}")
    hospitalizacion = hospitalizacion.page(page).per_page(per_page)
    if params[:sSearch].present?
      hospitalizacion = hospitalizacion.where("numero like :search or servicio like :search", search: "%#{params[:sSearch]}%")
    end
    hospitalizacion
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[numero servicio user_id iva total]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end