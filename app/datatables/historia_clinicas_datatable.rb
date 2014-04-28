class HistoriaClinicasDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: historia_clinicas.count,
      iTotalDisplayRecords: historia_clinicas.total_entries,
      aaData: data
    }
  end

private

  def data
    historia_clinicas.map do |historia|
      [
        (historia.numero),
        (historia.paciente.cliente.nombre),
        (historia.paciente.cliente.numero_de_identificacion),
        (historia.paciente.tipo),
        (link_to '', historia, :rel => 'tooltip', :title => 'Ver Ficha', class: "ttip fa fa-eye btn btn-info") + " " +
        (link_to '', @view.new_historia_clinica_registro_path(historia),:rel => 'tooltip', :title => 'Nuevo Registro', class: "ttip fa fa-folder-open btn btn-success")
      ]
    end 
  end

  def historia_clinicas
    @historia_clinicas ||= fetch_historia_clinicas
  end

  def fetch_historia_clinicas
    historia_clinicas = HistoriaClinica.order("#{sort_column} #{sort_direction}")
    historia_clinicas = historia_clinicas.page(page).per_page(per_page)
    if params[:sSearch].present?
      historia_clinicas = historia_clinicas.includes(:paciente).where("numero like :search or pacientes.tipo like :search", search: "%#{params[:sSearch]}%").references(:paciente)
    end
    historia_clinicas
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[numero nombre tipo estado ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end