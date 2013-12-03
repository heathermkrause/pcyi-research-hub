require 'test_helper'

class KeyfindingsControllerTest < ActionController::TestCase
  setup do
    @keyfinding = keyfindings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyfindings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyfinding" do
    assert_difference('Keyfinding.count') do
      post :create, keyfinding: { document_id: @keyfinding.document_id, keyfinding_text: @keyfinding.keyfinding_text }
    end

    assert_redirected_to keyfinding_path(assigns(:keyfinding))
  end

  test "should show keyfinding" do
    get :show, id: @keyfinding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyfinding
    assert_response :success
  end

  test "should update keyfinding" do
    put :update, id: @keyfinding, keyfinding: { document_id: @keyfinding.document_id, keyfinding_text: @keyfinding.keyfinding_text }
    assert_redirected_to keyfinding_path(assigns(:keyfinding))
  end

  test "should destroy keyfinding" do
    assert_difference('Keyfinding.count', -1) do
      delete :destroy, id: @keyfinding
    end

    assert_redirected_to keyfindings_path
  end
end
