class TraspasosDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view, place)
    @view = view
    @place = place
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
    case @place
    when "no_anulada"
      traspasos.map do |traspaso|
        [
          (traspaso.numero),
          (traspaso.servicio),
          (traspaso.user.username),
          (traspaso.entregado_a),
          (traspaso.fecha_emision),
          (link_to '', traspaso, :remote => true, :rel=> 'tooltip', :title=>'Mostrar','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip mostrar fa fa-eye btn btn-info") + " " +
          (link_to '', @view.anular_traspaso_path(traspaso), :remote => true, :rel => "tooltip",  'data-toggle' =>  "modal", 'data-target' => '#myModal', :title => 'Anular',  class: "ttip fa fa-thumbs-down btn btn-danger")
        ]
      end
    when "anulada"
      traspasos.map do |traspaso|
        [
          (traspaso.numero),
          (traspaso.fecha_emision),
          (traspaso.servicio),
          (traspaso.user.username),
          (traspaso.entregado_a),
          (traspaso.razon_anulada),
          (link_to '', traspaso, :remote => true, :rel=> 'tooltip', :title=>'Mostrar','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip mostrar fa fa-eye btn btn-info")
        ]
      end
    end
  end
  def traspasos
    @traspasos ||= fetch_traspasos
  end

  def fetch_traspasos
    case @place
    when "no_anulada"
      traspasos = Traspaso.where(:anulado => false).order("#{sort_column} #{sort_direction}")
    when "anulada"
      traspasos = Traspaso.where(:anulado => true).order("#{sort_column} #{sort_direction}")
    end
    traspasos = traspasos.page(page).per_page(per_page)
    if params[:sSearch].present?
      case @place
      when "no_anulada"
        traspasos = traspasos.where("numero like :search or servicio like :search", search: "%#{params[:sSearch]}%")
      when "anulada"
        traspasos = traspasos.where("numero like :search or servicio like :search", search: "%#{params[:sSearch]}%")
      end
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
