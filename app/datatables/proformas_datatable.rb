class ProformasDatatable
  delegate :params,:link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Proforma.count,
      iTotalDisplayRecords: proformas.total_entries,
      aaData: data
    }
  end

private

  def data
    proformas.map do |proforma|
      [
        (proforma.cliente.nombre),
        (proforma.numero),
        (proforma.total),
        (link_to '', proforma, :remote => true, :rel=> 'tooltip', :title=>'Mostrar','data-toggle' =>  "modal", 'data-target' => '#myModal', class: "ttip fa fa-eye btn btn-info")
        # (link_to 'Mostrar', @view.show(factura), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "btn btn-warning"})
        # (link_to '', @view.show_factura_path(factura), {:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal', class: "btn btn-warning"})
      ]
    end 
  end

  def proformas
    @proformas ||= fetch_proformas
  end

  def fetch_proformas
    proformas = Proforma.order("#{sort_column} #{sort_direction}")
    proformas = proformas.page(page).per_page(per_page)
    if params[:sSearch].present?
      proformas = proformas.where("numero like :search", search: "%#{params[:sSearch]}%")
    end
    proformas
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[cliente_id numero  total]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end