%w(Administrador Enfermera Vendedor Auxiliar_Estadística Administrador_Estadística Administrador_Farmacia Administrador_Enfermería Doctor).each do |nombre|
  Rol.create(nombre: nombre)
end
Cliente.create(nombre: "Consumidor Final", numero_de_identificacion: "9999999999", direccion: "")
cliente = Cliente.create(nombre: "Fabricio Flores", numero_de_identificacion: "1104015936", direccion: "Loja")
user = User.create(username: 'fabricio', password:'fabricio', cliente: cliente, rol: Rol.administrador)
cliente = Cliente.create(nombre: "Angel Valdez", numero_de_identificacion: "1103786990", direccion: "Loja")
user = User.create(username: 'angel', password:'valdez', cliente: cliente, rol: Rol.administrador)
cliente = Cliente.create(nombre: "Lenin Capa", numero_de_identificacion: "1104706922", direccion: "Loja")
user = User.create(username: 'lenin', password:'capa', cliente: cliente, rol: Rol.administrador)
