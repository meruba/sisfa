class FixingRoles < ActiveRecord::Migration
  def up
    remove_column :users, :rol
    %w(Administrador Enfermera Vendedor Administrador_Estadística Administrador_Farmacia Administrador_Enfermería).each do |nombre|
      Rol.create! nombre: nombre
    end
  end

  def down
    add_column :users, :rol, :string
    Rol.all.each do |rol|
      rol.destroy
    end
  end
end
