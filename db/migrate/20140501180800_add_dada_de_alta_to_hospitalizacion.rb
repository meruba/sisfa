class AddDadaDeAltaToHospitalizacion < ActiveRecord::Migration
  def change
    add_column :hospitalizacions, :dado_de_alta, :boolean, default: false
  end
end
