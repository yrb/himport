require "application_system_test_case"

class HiltiProjectsTest < ApplicationSystemTestCase
  setup do
    @hilti_project = hilti_projects(:one)
  end

  test "visiting the index" do
    visit hilti_projects_url
    assert_selector "h1", text: "Hilti projects"
  end

  test "should create hilti project" do
    visit hilti_projects_url
    click_on "New hilti project"

    fill_in "Address", with: @hilti_project.address
    fill_in "Approvals", with: @hilti_project.approvals
    fill_in "Configuration", with: @hilti_project.configuration
    fill_in "Fields", with: @hilti_project.fields
    fill_in "Floor plans", with: @hilti_project.floor_plans
    fill_in "Hilti import", with: @hilti_project.hilti_import_id
    fill_in "Name", with: @hilti_project.name
    fill_in "Products", with: @hilti_project.products
    fill_in "Reference", with: @hilti_project.reference
    click_on "Create Hilti project"

    assert_text "Hilti project was successfully created"
    click_on "Back"
  end

  test "should update Hilti project" do
    visit hilti_project_url(@hilti_project)
    click_on "Edit this hilti project", match: :first

    fill_in "Address", with: @hilti_project.address
    fill_in "Approvals", with: @hilti_project.approvals
    fill_in "Configuration", with: @hilti_project.configuration
    fill_in "Fields", with: @hilti_project.fields
    fill_in "Floor plans", with: @hilti_project.floor_plans
    fill_in "Hilti import", with: @hilti_project.hilti_import_id
    fill_in "Name", with: @hilti_project.name
    fill_in "Products", with: @hilti_project.products
    fill_in "Reference", with: @hilti_project.reference
    click_on "Update Hilti project"

    assert_text "Hilti project was successfully updated"
    click_on "Back"
  end

  test "should destroy Hilti project" do
    visit hilti_project_url(@hilti_project)
    click_on "Destroy this hilti project", match: :first

    assert_text "Hilti project was successfully destroyed"
  end
end
