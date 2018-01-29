require 'test_helper'

class SeguridadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get seguridad_index_url
    assert_response :success
  end

end
