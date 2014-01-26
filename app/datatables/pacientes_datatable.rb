class PacientesDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Cliente.count,
      iTotalDisplayRecords: pacientes.total_entries,
      aaData: data
    }
  end

private

  def data
    pacientes.map do |paciente|
      [
        (paciente.cliente.nombre),
        (paciente.cliente.numero_de_identificacion),
        # (paciente.cliente.direccion),
        (paciente.n_hclinica),        
        (link_to '', @view.edit_paciente_path(paciente), class: "ttip mostrar fa fa-eye btn btn-info"),
      ]
    end 
  end

  def pacientes
    @pacientes ||= fetch_pacientes
  end

  def fetch_pacientes
    pacientes = Paciente.order("#{sort_column} #{sort_direction}")
    pacientes = pacientes.page(page).per_page(per_page)
    if params[:sSearch].present?
      pacientes = pacientes.where("n_hclinica like :search", search: "%#{params[:sSearch]}%")
    end
    pacientes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[n_hclinica]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end