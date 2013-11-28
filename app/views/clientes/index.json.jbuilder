json.array!(@clientes) do |cliente|
  json.extract! cliente, :nombre, :direccion, :numero_de_identificacion, :telefono, :email
  json.url cliente_url(cliente, format: :json)
end
