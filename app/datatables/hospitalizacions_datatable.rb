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
    hospitalizacion.map do |h|
      [
        (h.numero),
        (h.hospitalizacion_registro.paciente.cliente.nombre),
        (h.subtotal),
        (h.iva),
        (h.total),
        (@view.human_boolean(h.hospitalizacion_registro.alta)),
        (link_to '', h, :remote => true, :rel=> 'tooltip', :title=>'Imprimir','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip mostrar fa fa-print btn btn-info") + " " +
        (link_to '', h, :rel=> 'tooltip', :title=>'Despachar', class: "ttip mostrar fa fa-check btn btn-success")
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