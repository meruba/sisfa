# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
%w(Administrador Enfermera Vendedor Administrador_Estadística Administrador_Farmacia Administrador_Enfermería).each do |nombre|
  Rol.create(nombre: nombre)
end
cliente = Cliente.create(nombre: "Fabricio Flores", numero_de_identificacion: "1104015936")
user = User.create(username: 'fabricio', password:'fabricio', cliente: cliente, rol: Rol.administrador)
cliente = Cliente.create(nombre: "Angel Valdez", numero_de_identificacion: "1103786990")
user = User.create(username: 'angel', password:'valdez', cliente: cliente, rol: Rol.administrador)
cliente = Cliente.create(nombre: "Lenin Capa", numero_de_identificacion: "1104706922")
user = User.create(username: 'lenin', password:'capa', cliente: cliente, rol: Rol.administrador)