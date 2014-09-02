class ProductImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def save
    if imported_products.map(&:valid?).all?
      imported_products.each(&:save!)
      true
    else
      imported_products.each_with_index do |product, index|
        product.errors.full_messages.each do |message|
          errors.add :base, "Fila #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_products
    @imported_products ||= load_imported_products
  end

  def load_imported_products
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      parameters = ActionController::Parameters.new(row.to_hash)
      producto = Producto.find_by_id(parameters[:id]) || Producto.new
      producto.attributes = parameters.permit(:nombre, :codigo, :categoria, :casa_comercial, :nombre_generico, :precio_compra, :ganancia)
      producto
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
