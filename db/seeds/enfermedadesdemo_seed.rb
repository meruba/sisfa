enfermedades = [
{codigo: 'A00', nombre: 'Cólera'},
{codigo: 'A000', nombre: 'Cólera debido a Vibrio cholerae 01, biotipo cholerae'},
{codigo: 'A001', nombre: 'Cólera debido a Vibrio cholerae 01, biotipo El Tor'},
{codigo: 'A009', nombre: 'Cólera, no especificado'},
{codigo: 'B660', nombre: 'Opistorquiasis'},
{codigo: 'B661', nombre: 'Clonorquiasis'},
{codigo: 'B662', nombre: 'Dicrocoeliasis'},
{codigo: 'B663', nombre: 'Fascioliasis'},
{codigo: 'C942', nombre: 'Leucemia megacarioblástica aguda'},
{codigo: 'C943', nombre: 'Leucemia de mastocitos'},
{codigo: 'C944', nombre: 'Panmielosis aguda'},
{codigo: 'C945', nombre: 'Mielofibrosis aguda'}
].each do |enfermedad|
  Enfermedad.where(codigo: enfermedad[:codigo], nombre: enfermedad[:nombre]).first_or_initialize.tap do |c|
    c.update_attributes! enfermedad
  end
end
