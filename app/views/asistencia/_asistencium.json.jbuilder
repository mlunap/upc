json.extract! asistencium, :id, :empleado_id, :cliente_id, :tipo_asistencia, :fecha_asistencia, :ip_conexion, :latitud, :longitud, :created_at, :updated_at
json.url asistencium_url(asistencium, format: :json)
