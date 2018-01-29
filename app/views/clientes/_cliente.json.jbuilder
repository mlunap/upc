json.extract! cliente, :id, :ruc, :razon_social, :direccion, :telefono, :estado, :usuario_creacion, :fecha_creacion, :usuario_modificacion, :fecha_modificacion, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
