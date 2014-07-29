# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
{	codigo:	"F454"	, nombre:	"Trastorno de dolor persistente somatomorfo"	},
{ codigo: "D643" , nombre: "Otras anemias sideroblásticas" },
{ codigo: "D644" , nombre: "Anemia diseritropoyética congénita " },
{ codigo: "D648" , nombre: "Otras anemias especificadas" },
{ codigo: "D649" , nombre: "Anemia de tipo no especificado " },
{ codigo: "D65" , nombre: "Coagulación intravascular diseminada [síndrome de desfibrinación]" },
{ codigo: "D66" , nombre: "Deficiencia hereditaria del factor VIII" },
{ codigo: "D67" , nombre: "Deficiencia hereditaria del factor IX" },
{ codigo: "D68" , nombre: "Otros defectos de la coagulación " },
{ codigo: "D680" , nombre: "Enfermedad de von Willebrand " },
{ codigo: "D681" , nombre: "Deficiencia hereditaria del factor XI" },
{ codigo: "D682" , nombre: "Deficiencia hereditaria de otros factores de la coagulación" },
{ codigo: "R460" , nombre: "Muy bajo nivel de higiene personal" },
{ codigo: "R461" , nombre: "Apariencia personal extraña" },
{ codigo: "R462" , nombre: "Conducta extraña e inexplicable" },
{ codigo: "R463" , nombre: "Hiperactividad " },
{ codigo: "R464" , nombre: "Lentitud y pobre respuesta" },
{ codigo: "R465" , nombre: "Suspicacia y evasividad marcadas" },
{ codigo: "R466" , nombre: "Preocupación indebida por sucesos que causan tensión" },
{ codigo: "P701" , nombre: "Síndrome del recién nacido de madre diabética" },
{ codigo: "P702" , nombre: "Diabetes mellitus neonatal" },
{ codigo: "P703" , nombre: "Hipoglicemia neonatal yatrogénica" },
{ codigo: "P704" , nombre: "Otras hipoglicemias neonatales" },
{ codigo: "P708" , nombre: "Otros trastornos transitorios del metabolismo de los carbohidratos en el feto y el recién nacido" }
].each do |enfermedad|
  Enfermedad.where(codigo: enfermedad[:codigo], nombre: enfermedad[:nombre]).first_or_initialize.tap do |c|
    c.update_attributes! enfermedad
  end
end
