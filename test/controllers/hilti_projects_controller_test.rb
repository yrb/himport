require "test_helper"

class HiltiProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hilti_project = hilti_projects(:one)
  end

  test "should get index" do
    get hilti_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_hilti_project_url
    assert_response :success
  end

  test "should create hilti_project" do
    assert_difference("HiltiProject.count") do
      post hilti_projects_url, params: { hilti_project: { address: @hilti_project.address, approvals: @hilti_project.approvals, configuration: @hilti_project.configuration, fields: @hilti_project.fields, floor_plans: @hilti_project.floor_plans, hilti_import_id: @hilti_project.hilti_import_id, name: @hilti_project.name, products: @hilti_project.products, reference: @hilti_project.reference } }
    end

    assert_redirected_to hilti_project_url(HiltiProject.last)
  end

  test "should show hilti_project" do
    get hilti_project_url(@hilti_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_hilti_project_url(@hilti_project)
    assert_response :success
  end

  test "should update hilti_project" do
    patch hilti_project_url(@hilti_project), params: { hilti_project: { address: @hilti_project.address, approvals: @hilti_project.approvals, configuration: @hilti_project.configuration, fields: @hilti_project.fields, floor_plans: @hilti_project.floor_plans, hilti_import_id: @hilti_project.hilti_import_id, name: @hilti_project.name, products: @hilti_project.products, reference: @hilti_project.reference } }
    assert_redirected_to hilti_project_url(@hilti_project)
  end

  test "should destroy hilti_project" do
    assert_difference("HiltiProject.count", -1) do
      delete hilti_project_url(@hilti_project)
    end

    assert_redirected_to hilti_projects_url
  end
end
