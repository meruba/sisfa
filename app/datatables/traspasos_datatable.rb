class TraspasosDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Traspaso.count,
      iTotalDisplayRecords: traspasos.total_entries,
      aaData: data
    }
  end

private

  def data
    traspasos.map do |traspaso|
      [
        (traspaso.numero),
        (traspaso.servicio),
        (traspaso.fecha_emision),
        (traspaso.user.username),
        (traspaso.iva),
        (traspaso.total),
        (link_to '', traspaso, :remote => true, :rel=> 'tooltip', :title=>'Mostrar','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip mostrar fa fa-eye btn btn-info")
      ]
    end 
  end

  def traspasos
    @traspasos ||= fetch_traspasos
  end

  def fetch_traspasos
    traspasos = Traspaso.order("#{sort_column} #{sort_direction}")
    traspasos = traspasos.page(page).per_page(per_page)
    if params[:sSearch].present?
      traspasos = traspasos.where("numero like :search or servicio like :search", search: "%#{params[:sSearch]}%")
    end
    traspasos
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