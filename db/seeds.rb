# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
%w(Administrador Enfermera Vendedor Administrador_Estadística Administrador_Farmacia Administrador_Enfermería Doctor).each do |nombre|
  Rol.create(nombre: nombre)
end
cliente = Cliente.create(nombre: "Fabricio Flores", numero_de_identificacion: "1104015936")
user = User.create(username: 'fabricio', password:'fabricio', cliente: cliente, rol: Rol.administrador)
cliente = Cliente.create(nombre: "Angel Valdez", numero_de_identificacion: "1103786990")
user = User.create(username: 'angel', password:'valdez', cliente: cliente, rol: Rol.administrador)
cliente = Cliente.create(nombre: "Lenin Capa", numero_de_identificacion: "1104706922")
user = User.create(username: 'lenin', password:'capa', cliente: cliente, rol: Rol.administrador)

#algunas enfermedades
enfermedades = [
{	codigo:	"A00"	, nombre:	"Cólera"	},
{	codigo:	"A000"	, nombre:	"Cólera debido a Vibrio cholerae 01, biotipo cholerae"	},
{	codigo:	"A001"	, nombre:	"Cólera debido a Vibrio cholerae 01, biotipo El Tor"	},
{	codigo:	"A009"	, nombre:	"Cólera, no especificado"	},
{	codigo:	"B450"	, nombre:	"Criptococosis pulmonar"	},
{	codigo:	"	B451"	, nombre:	"Criptococosis cerebral"	},
{	codigo:	"B452"	, nombre:	"Criptococosis cutánea"	},
{	codigo:	"B453"	, nombre:	"Criptococosis ósea"	},
{	codigo:	"A01"	, nombre:	"Fiebres tifoidea y paratifoidea"	},
{	codigo:	"A010"	, nombre:	"Fiebre tifoidea"	},
{	codigo:	"A011"	, nombre:	"Fiebre paratifoidea A"	},
{	codigo:	"A012"	, nombre:	"Fiebre paratifoidea B"	},
{	codigo:	"A013"	, nombre:	"Fiebre paratifoidea C"	},
{	codigo:	"C711"	, nombre:	"Tumor maligno del lóbulo frontal"	},
{	codigo:	"C712"	, nombre:	"Tumor maligno del lóbulo temporal"	},
{	codigo:	"C713"	, nombre:	"Tumor maligno del lóbulo parietal"	},
{	codigo:	"Z974"	, nombre:	"Presencia de audífono externo	"	},
{	codigo:	"Z975"	, nombre:	"Presencia de dispositivo anticonceptivo (intrauterino)"	},
{	codigo:	"F45"	, nombre:	"Trastornos somatomorfos"	},
{	codigo:	"F450"	, nombre:	"Trastorno de somatización"	},
{	codigo:	"F451"	, nombre:	"Trastorno somatomorfo indiferenciado"},
{	codigo:	"F452"	, nombre:	"Trastorno hipocondríaco"	},
{	codigo:	"F453"	, nombre:	"Disfunción autonómica somatomorfa"	},
{	codigo:	"F454"	, nombre:	"Trastorno de dolor persistente somatomorfo"	}
].each do |enfermedad|
  Enfermedad.where(codigo: enfermedad[:codigo], nombre: enfermedad[:nombre]).first_or_initialize.tap do |c|
    c.update_attributes! enfermedad
  end
end
