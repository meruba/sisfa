# == Schema Information
#
# Table name: liquidacions
#
#  id                       :integer          not null, primary key
#  iva_ventanilla           :float            default(0.0)
#  iva_hospitalizacion      :float            default(0.0)
#  iva_traspaso             :float            default(0.0)
#  iva_compra               :float            default(0.0)
#  subtotal_ventanilla      :float            default(0.0)
#  subtotal_hospitalizacion :float            default(0.0)
#  subtotal_traspaso        :float            default(0.0)
#  subtotal_compra          :float            default(0.0)
#  total_ventanilla         :float            default(0.0)
#  total_hospitalizacion    :float            default(0.0)
#  total_traspaso           :float            default(0.0)
#  total_compra             :float            default(0.0)
#  emitidos_ventanilla      :integer          default(0)
#  emitidos_hospitalizacion :integer          default(0)
#  emitidos_traspaso        :integer          default(0)
#  emitidos_compra          :integer          default(0)
#  fecha                    :date
#  created_at               :datetime
#  updated_at               :datetime
#

class Liquidacion < ActiveRecord::Base

	#methods
	def self.add_hospitalizacion(h)
		b = self.where(:fecha => h.fecha_emision).first
		if b.nil? == true
			self.create(:iva_hospitalizacion => h.iva,
			:subtotal_hospitalizacion => h.subtotal,
			:total_hospitalizacion => h.total,
			:emitidos_hospitalizacion => 1,
			:fecha => h.fecha_emision
			)
		else
			self.update(b,
			:iva_hospitalizacion => b.iva_hospitalizacion + h.iva,
			:subtotal_hospitalizacion => b.subtotal_hospitalizacion + h.subtotal,
			:emitidos_hospitalizacion => b.emitidos_hospitalizacion + 1,
			:total_hospitalizacion => b.total_hospitalizacion + h.total
			)
		end
	end

	def self.add_factura(f)
		b = self.where(:fecha => f.fecha_de_emision.to_date).first
		if b.nil? == true
			self.create(
			:iva_ventanilla => f.iva, 
			:subtotal_ventanilla => f.subtotal_0,
			:total_ventanilla => f.total,
			:emitidos_ventanilla => 1,
			:fecha => f.fecha_de_emision
			)
		else
			self.update(b,
			:iva_ventanilla => b.iva_ventanilla + f.iva, 
			:subtotal_ventanilla => b.subtotal_ventanilla + f.subtotal_0,
			:total_ventanilla => b.total_ventanilla + f.total,
			:emitidos_ventanilla => b.emitidos_ventanilla + 1
			)
		end
	end

	def self.add_traspaso(t)
		b = self.where(:fecha => t.fecha_emision).first
		if b.nil? == true
			self.create(
			:iva_traspaso => t.iva, 
			:subtotal_traspaso => t.subtotal,
			:total_traspaso => t.total,
			:emitidos_traspaso => 1,
			:fecha => t.fecha_emision
			)
		else
			self.update(b,
			:iva_traspaso => b.iva_traspaso + t.iva, 
			:subtotal_traspaso => b.subtotal_traspaso + t.subtotal,
			:total_traspaso => b.total_traspaso + t.total,
			:emitidos_traspaso => b.emitidos_traspaso + 1
			)
		end
	end
end
