# == Schema Information
#
# Table name: liquidacions
#
#  id                            :integer          not null, primary key
#  iva_ventanilla                :float            default(0.0)
#  iva_hospitalizacion           :float            default(0.0)
#  iva_traspaso                  :float            default(0.0)
#  iva_compra                    :float            default(0.0)
#  subtotal_ventanilla           :float            default(0.0)
#  subtotal_hospitalizacion      :float            default(0.0)
#  subtotal_traspaso             :float            default(0.0)
#  subtotal_compra               :float            default(0.0)
#  total_ventanilla              :float            default(0.0)
#  total_hospitalizacion         :float            default(0.0)
#  total_traspaso                :float            default(0.0)
#  total_compra                  :float            default(0.0)
#  emitidos_ventanilla           :integer          default(0)
#  emitidos_hospitalizacion      :integer          default(0)
#  emitidos_traspaso             :integer          default(0)
#  emitidos_compra               :integer          default(0)
#  fecha                         :date
#  created_at                    :datetime
#  updated_at                    :datetime
#  subtotal12_ventanilla         :float            default(0.0)
#  subtotal12_hospitalizacion    :float            default(0.0)
#  subtotal12_traspaso           :float            default(0.0)
#  subtotal12_venta              :float            default(0.0)
#  subtotal_venta                :float            default(0.0)
#  iva_venta                     :float            default(0.0)
#  total_venta                   :float            default(0.0)
#  subtotal12_compra             :float            default(0.0)
#  anulados_ventanilla           :integer          default(0)
#  total_sin_iva_ventanilla      :float            default(0.0)
#  total_sin_iva_hospitalizacion :float            default(0.0)
#  total_sin_iva_traspaso        :float            default(0.0)
#  total_sin_iva_compra          :float            default(0.0)
#  total_sin_iva_venta           :float            default(0.0)
#  saldo_anterior                :float            default(0.0)
#  saldo_final                   :float            default(0.0)
#  costo_venta                   :float            default(0.0)
#  utilidad                      :float            default(0.0)
#

class Liquidacion < ActiveRecord::Base

	#methods
	def self.add_hospitalizacion(h, costo_venta)
		b = self.where(:fecha => h.fecha_emision.beginning_of_month).first
		if b.nil? == true # por primera vez
			self.create(:iva_hospitalizacion => h.iva,
			:subtotal_hospitalizacion => h.subtotal,
			:subtotal12_hospitalizacion => h.subtotal_12,
			:total_hospitalizacion => h.total,
			:emitidos_hospitalizacion => 1,
			:fecha => Time.now.beginning_of_month,
			:iva_venta => h.iva,
			:subtotal_venta => h.subtotal,
			:subtotal12_venta => h.subtotal_12,
			:total_sin_iva_hospitalizacion => h.subtotal + h.subtotal_12,
			:total_sin_iva_venta => h.subtotal + h.subtotal_12,
			:total_venta => h.total
			)
		else #se actualiza liquidacion mes
			self.update(b,
			:iva_hospitalizacion => b.iva_hospitalizacion + h.iva,
			:subtotal_hospitalizacion => b.subtotal_hospitalizacion + h.subtotal,
			:subtotal12_hospitalizacion => b.subtotal12_hospitalizacion + h.subtotal_12,
			:emitidos_hospitalizacion => b.emitidos_hospitalizacion + 1,
			:total_hospitalizacion => b.total_hospitalizacion + h.total,
			:iva_venta => b.iva_venta + h.iva,
			:subtotal_venta => b.subtotal_venta + h.subtotal,
			:subtotal12_venta => b.subtotal12_venta + h.subtotal_12,
			:total_sin_iva_hospitalizacion => b.total_sin_iva_hospitalizacion + h.subtotal + h.subtotal_12,
			:total_sin_iva_venta => b.total_sin_iva_venta + h.subtotal + h.subtotal_12,
			:total_venta => b.total_venta +  h.total,
			:costo_venta => b.costo_venta + costo_venta
			)
		end
	end

	def self.add_factura(f, costo_venta)
		b = self.where(:fecha => f.fecha_de_emision.to_date.beginning_of_month).first
		if b.nil? == true #por primea vez
			self.create(
			:iva_ventanilla => f.iva, 
			:subtotal_ventanilla => f.subtotal_0,
			:subtotal12_ventanilla => f.subtotal_12,
			:total_ventanilla => f.total,
			:emitidos_ventanilla => 1,
			:fecha => Time.now.beginning_of_month,
			:iva_venta => f.iva,
			:subtotal_venta => f.subtotal_0,
			:subtotal12_venta => f.subtotal_12,
			:total_sin_iva_ventanilla => f.subtotal_0 + f.subtotal_12,
			:total_sin_iva_venta => f.subtotal_0 + f.subtotal_12,
			:total_venta => f.total,
			:costo_venta => costo_venta
			)
		else #se actualiza liquidacion mes
			if f.anulada != true
				self.update(b,
				:iva_ventanilla => b.iva_ventanilla + f.iva, 
				:subtotal_ventanilla => b.subtotal_ventanilla + f.subtotal_0,
				:subtotal12_ventanilla => b.subtotal12_ventanilla + f.subtotal_12,
				:total_ventanilla => b.total_ventanilla + f.total,
				:emitidos_ventanilla => b.emitidos_ventanilla + 1,
				:iva_venta => b.iva_venta + f.iva,
				:subtotal_venta => b.subtotal_venta + f.subtotal_0,
				:subtotal12_venta => b.subtotal12_venta + f.subtotal_12,
				:total_sin_iva_ventanilla => b.total_sin_iva_ventanilla + f.subtotal_0 + f.subtotal_12,
				:total_sin_iva_venta => b.total_sin_iva_venta + f.subtotal_0 + f.subtotal_12,
				:total_venta => b.total_venta +  f.total,
				:costo_venta => b.costo_venta + costo_venta
			)
			else	#si anulan factura se resta valores, se actualiza liquidacion mes
				self.update(b,
				:iva_ventanilla => b.iva_ventanilla - f.iva, 
				:subtotal_ventanilla => b.subtotal_ventanilla - f.subtotal_0,
				:subtotal12_ventanilla => b.subtotal12_ventanilla - f.subtotal_12,
				:total_ventanilla => b.total_ventanilla - f.total,
				:emitidos_ventanilla => b.emitidos_ventanilla - 1,
				:anulados_ventanilla => b.anulados_ventanilla + 1,
				:iva_venta => b.iva_venta - f.iva,
				:subtotal_venta => b.subtotal_venta - f.subtotal_0,
				:subtotal12_venta => b.subtotal12_venta - f.subtotal_12,
				:total_sin_iva_ventanilla => b.total_sin_iva_ventanilla - f.subtotal_0 - f.subtotal_12,
				:total_sin_iva_venta => b.total_sin_iva_venta - f.subtotal_0 - f.subtotal_12,
				:total_venta => b.total_venta -  f.total,
				:costo_venta => b.costo_venta - costo_venta
				)
			end
		end
	end

	def self.add_traspaso(t, costo_venta)
		b = self.where(:fecha => t.fecha_emision.beginning_of_month).first
		if b.nil? == true #por primea vez
			self.create(
			:iva_traspaso => t.iva, 
			:subtotal_traspaso => t.subtotal,
			:subtotal12_traspaso => t.subtotal_12,
			:total_traspaso => t.total,
			:emitidos_traspaso => 1,
			:fecha => Time.now.beginning_of_month,
			:iva_venta => t.iva,
			:subtotal_venta => t.subtotal,
			:subtotal12_venta => t.subtotal_12,
			:total_sin_iva_traspaso => t.subtotal + t.subtotal_12,
			:total_sin_iva_venta => t.subtotal + t.subtotal_12,
			:total_venta => t.total,
			:costo_venta => costo_venta
			)
		else #se actualiza liquidacion mes
			self.update(b,
			:iva_traspaso => b.iva_traspaso + t.iva, 
			:subtotal_traspaso => b.subtotal_traspaso + t.subtotal,
			:subtotal12_traspaso => b.subtotal12_traspaso + t.subtotal_12,
			:total_traspaso => b.total_traspaso + t.total,
			:emitidos_traspaso => b.emitidos_traspaso + 1,
			:iva_venta => b.iva_venta + t.iva,
			:subtotal_venta => b.subtotal_venta + t.subtotal,
			:subtotal12_venta => b.subtotal12_venta + t.subtotal_12,
			:total_sin_iva_traspaso => b.total_sin_iva_traspaso + t.subtotal + t.subtotal_12,
			:total_sin_iva_venta => b.total_sin_iva_venta + t.subtotal + t.subtotal_12,
			:total_venta => b.total_venta + t.total,
			:costo_venta => b.costo_venta + costo_venta
			)
		end
	end

	def self.add_compra(c)
		b = self.where(:fecha => c.fecha_de_emision.to_date.beginning_of_month).first
		if b.nil? == true #por primea vez
			self.create(
			:iva_compra => c.iva, 
			:subtotal_compra => c.subtotal_0,
			:subtotal12_compra => c.subtotal_12,
			:total_sin_iva_compra => c.subtotal_0 +  c.subtotal_12,
			:total_compra => c.total,
			:emitidos_compra => 1,
			:fecha => Time.now.beginning_of_month
			)
		else #se actualiza liquidacion mes
			self.update(b,
			:iva_compra => b.iva_traspaso + c.iva, 
			:subtotal_compra => b.subtotal_compra + c.subtotal_0,
			:subtotal12_compra => b.subtotal12_compra + c.subtotal_12,
			:total_compra => b.total_compra + c.total,
			:total_sin_iva_compra => b.total_sin_iva_compra + c.subtotal_0 +  c.subtotal_12,
			:emitidos_compra => b.emitidos_compra + 1
			)
		end
	end
end
