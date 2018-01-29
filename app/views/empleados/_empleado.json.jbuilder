json.extract! empleado, :id, :dni, :nombres, :apellidos, :correo, :usuario, :password, :tipo_usuario, :hora_ingreso, :hora_salida, :estado, :foto, :usuario_creacion, :fecha_creacion, :usuario_modificacion, :fecha_modificacion, :created_at, :updated_at
json.url empleado_url(empleado, format: :json)
