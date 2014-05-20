class PacientesDatatable
  delegate :params, :link_to, :h, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: pacientes.count,
      iTotalDisplayRecords: pacientes.total_entries,
      aaData: data
    }
  end

private

  def data
    pacientes.map do |paciente|
      [
        (paciente.n_hclinica),        
        (paciente.cliente.nombre),
        (paciente.cliente.numero_de_identificacion),
        (paciente.tipo),
        (link_to '', @view.new_paciente_hospitalizacion_registro_path(paciente),{:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal',:rel => 'tooltip', :title => 'Hospitalizacion', class: "ttip fa fa-hospital-o btn btn-success"})+" "+
        (link_to '', @view.new_paciente_emergencia_registro_path(paciente),{:remote => true, 'data-toggle' =>  "modal", 'data-target' => '#myModal',:rel => 'tooltip', :title => 'Emergencia', class: "ttip fa fa-plus btn btn-danger"})+" "+
        (link_to '', paciente, :rel => 'tooltip', :title => 'Ver Ficha', class: "ttip fa fa-eye btn btn-info")
      ]
    end 
  end

  def pacientes
    @pacientes ||= fetch_pacientes
  end

  def fetch_pacientes
    pacientes = Paciente.includes(:cliente).order("#{sort_column} #{sort_direction}")
    pacientes = pacientes.page(page).per_page(per_page)
    if params[:sSearch].present?
      pacientes = pacientes.includes(:cliente).where("n_hclinica like :search or clientes.nombre like :search or clientes.numero_de_identificacion like :search", search: "%#{params[:sSearch]}%").references(:cliente)
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
    columns = %w[n_hclinica cliente_id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end