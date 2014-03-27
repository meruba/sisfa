# == Schema Information
#
# Table name: ingreso_productos
#
#  id              :integer          not null, primary key
#  lote            :string(255)
#  fecha_caducidad :date
#  cantidad        :integer
#  producto_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class IngresoProducto < ActiveRecord::Base
  
#relationships
  has_many :item_facturas
  has_many :item_proformas
  has_many :item_traspasos
  has_many :item_hospitalizacion
  belongs_to :producto
  has_many :antiguos, :foreign_key => 'antiguo_id', :class_name => "Canje"
  has_many :nuevos, :foreign_key => 'nuevo_id', :class_name => "Canje"

#validations
  validates :cantidad, :fecha_caducidad, :presence => true
  validates :cantidad, :numericality => { :greater_than_or_equal_to => 0}

#callbacks
  after_create :set_entrada_kardex
  before_destroy :set_salida_kardex

#methods

  def self.autocomplete(params)
    productos = IngresoProducto.includes(:producto).where("cantidad != 0 and productos.nombre like ?", "%#{params}%").references(:producto)
    productos = productos.map do |ingreso|
    {
      :id => ingreso.producto.id,
      :label => ingreso.producto.nombre + "/" + "Lote:" + ingreso.lote ,
      :value => ingreso.producto.nombre,
      :precio_venta => ingreso.producto.precio_venta,
      :id_ingreso => ingreso.id,
      :iva => ingreso.producto.hasiva,
      :casa_comercial => ingreso.producto.casa_comercial
    }
    end
    productos
  end

  private

  def set_entrada_kardex
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Entrada", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.producto.precio_compra )
  end

  def set_salida_kardex
    Lineakardex.create(:kardex => self.producto.kardex, :tipo => "Salida", :fecha => Time.now, :cantidad => self.cantidad, :v_unitario => self.producto.precio_compra, :observaciones => "Eliminado desde producto" )
  end
end
