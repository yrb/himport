require "test_helper"

class ImportProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @import_project = import_projects(:one)
  end

  test "should get index" do
    get import_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_import_project_url
    assert_response :success
  end

  test "should create import_project" do
    assert_difference("ImportProject.count") do
      post import_projects_url, params: { import_project: { label: @import_project.label, organisation_id: @import_project.organisation_id, template: @import_project.template, token: @import_project.token } }
    end

    assert_redirected_to import_project_url(ImportProject.last)
  end

  test "should show import_project" do
    get import_project_url(@import_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_import_project_url(@import_project)
    assert_response :success
  end

  test "should update import_project" do
    patch import_project_url(@import_project), params: { import_project: { label: @import_project.label, organisation_id: @import_project.organisation_id, template: @import_project.template, token: @import_project.token } }
    assert_redirected_to import_project_url(@import_project)
  end

  test "should destroy import_project" do
    assert_difference("ImportProject.count", -1) do
      delete import_project_url(@import_project)
    end

    assert_redirected_to import_projects_url
  end
end
