require "test_helper"

class InspectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inspection = inspections(:one)
  end

  test "should get index" do
    get inspections_url
    assert_response :success
  end

  test "should get new" do
    get new_inspection_url
    assert_response :success
  end

  test "should create inspection" do
    assert_difference("Inspection.count") do
      post inspections_url, params: { inspection: { category_id: @inspection.category_id, clarinspect_id: @inspection.clarinspect_id, clarinspect_inspection: @inspection.clarinspect_inspection, hilti_import_id: @inspection.hilti_import_id, hilti_project_id: @inspection.hilti_project_id, penetration: @inspection.penetration, project_id: @inspection.project_id, reference: @inspection.reference } }
    end

    assert_redirected_to inspection_url(Inspection.last)
  end

  test "should show inspection" do
    get inspection_url(@inspection)
    assert_response :success
  end

  test "should get edit" do
    get edit_inspection_url(@inspection)
    assert_response :success
  end

  test "should update inspection" do
    patch inspection_url(@inspection), params: { inspection: { category_id: @inspection.category_id, clarinspect_id: @inspection.clarinspect_id, clarinspect_inspection: @inspection.clarinspect_inspection, hilti_import_id: @inspection.hilti_import_id, hilti_project_id: @inspection.hilti_project_id, penetration: @inspection.penetration, project_id: @inspection.project_id, reference: @inspection.reference } }
    assert_redirected_to inspection_url(@inspection)
  end

  test "should destroy inspection" do
    assert_difference("Inspection.count", -1) do
      delete inspection_url(@inspection)
    end

    assert_redirected_to inspections_url
  end
end
