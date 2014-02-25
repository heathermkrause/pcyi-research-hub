require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @document = documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post :create, document: { author: @document.author, data_availablity: @document.data_availablity, publication_date: @documenpublication_datert, key_ages: @document.key_ages, key_findings: @document.key_findings, key_recommendations: @document.key_recommendations, keywords: @document.keywords, notes_on_mythodology: @document.notes_on_mythodology, report_name: @document.report_name, sponsoring_orgnization: @document.sponsoring_orgnization, target_population: @document.target_population, user_id: @document.user_id }
    end

    assert_redirected_to document_path(assigns(:document))
  end

  test "should show document" do
    get :show, id: @document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document
    assert_response :success
  end

  test "should update document" do
    put :update, id: @document, document: { author: @document.author, data_availablity: @document.data_availablipublication_dateport: @docpublication_datereport, key_ages: @document.key_ages, key_findings: @document.key_findings, key_recommendations: @document.key_recommendations, keywords: @document.keywords, notes_on_mythodology: @document.notes_on_mythodology, report_name: @document.report_name, sponsoring_orgnization: @document.sponsoring_orgnization, target_population: @document.target_population, user_id: @document.user_id }
    assert_redirected_to document_path(assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, id: @document
    end

    assert_redirected_to documents_path
  end
end
