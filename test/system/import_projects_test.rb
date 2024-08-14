require "application_system_test_case"

class ImportProjectsTest < ApplicationSystemTestCase
  setup do
    @import_project = import_projects(:one)
  end

  test "visiting the index" do
    visit import_projects_url
    assert_selector "h1", text: "Import projects"
  end

  test "should create import project" do
    visit import_projects_url
    click_on "New import project"

    fill_in "Label", with: @import_project.label
    fill_in "Organisation", with: @import_project.organisation_id
    fill_in "Template", with: @import_project.template
    fill_in "Token", with: @import_project.token
    click_on "Create Import project"

    assert_text "Import project was successfully created"
    click_on "Back"
  end

  test "should update Import project" do
    visit import_project_url(@import_project)
    click_on "Edit this import project", match: :first

    fill_in "Label", with: @import_project.label
    fill_in "Organisation", with: @import_project.organisation_id
    fill_in "Template", with: @import_project.template
    fill_in "Token", with: @import_project.token
    click_on "Update Import project"

    assert_text "Import project was successfully updated"
    click_on "Back"
  end

  test "should destroy Import project" do
    visit import_project_url(@import_project)
    click_on "Destroy this import project", match: :first

    assert_text "Import project was successfully destroyed"
  end
end
