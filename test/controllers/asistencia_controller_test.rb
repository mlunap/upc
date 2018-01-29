require 'test_helper'

class AsistenciaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asistencium = asistencia(:one)
  end

  test "should get index" do
    get asistencia_url
    assert_response :success
  end

  test "should get new" do
    get new_asistencium_url
    assert_response :success
  end

  test "should create asistencium" do
    assert_difference('Asistencium.count') do
      post asistencia_url, params: { asistencium: { cliente_id: @asistencium.cliente_id, empleado_id: @asistencium.empleado_id, fecha_asistencia: @asistencium.fecha_asistencia, ip_conexion: @asistencium.ip_conexion, latitud: @asistencium.latitud, longitud: @asistencium.longitud, tipo_asistencia: @asistencium.tipo_asistencia } }
    end

    assert_redirected_to asistencium_url(Asistencium.last)
  end

  test "should show asistencium" do
    get asistencium_url(@asistencium)
    assert_response :success
  end

  test "should get edit" do
    get edit_asistencium_url(@asistencium)
    assert_response :success
  end

  test "should update asistencium" do
    patch asistencium_url(@asistencium), params: { asistencium: { cliente_id: @asistencium.cliente_id, empleado_id: @asistencium.empleado_id, fecha_asistencia: @asistencium.fecha_asistencia, ip_conexion: @asistencium.ip_conexion, latitud: @asistencium.latitud, longitud: @asistencium.longitud, tipo_asistencia: @asistencium.tipo_asistencia } }
    assert_redirected_to asistencium_url(@asistencium)
  end

  test "should destroy asistencium" do
    assert_difference('Asistencium.count', -1) do
      delete asistencium_url(@asistencium)
    end

    assert_redirected_to asistencia_url
  end
end
