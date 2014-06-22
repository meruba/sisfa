class ClienteImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_clientes.map(&:valid?).all?
      imported_clientes.each(&:save!)
      true
    else
      imported_clientes.each_with_index do |cliente, index|
        cliente.errors.full_messages.each do |message|
          errors.add :base, "Fila #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_clientes
    @imported_clientes ||= load_imported_clientes
  end

  def load_imported_clientes
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      parameters = ActionController::Parameters.new(row.to_hash)
      cliente = Cliente.find_by_id(parameters[:id]) || Cliente.new
      cliente.attributes = parameters.permit(:id, :ciudad, :fecha_nacimiento,:telefono, :email, :estado_civil, :direccion, :nombre, :numero_de_identificacion, :sexo)
      cliente
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Tipo de archivo desconocido"
    end
  end
end