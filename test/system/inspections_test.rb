require "application_system_test_case"

class InspectionsTest < ApplicationSystemTestCase
  setup do
    @inspection = inspections(:one)
  end

  test "visiting the index" do
    visit inspections_url
    assert_selector "h1", text: "Inspections"
  end

  test "should create inspection" do
    visit inspections_url
    click_on "New inspection"

    fill_in "Category", with: @inspection.category_id
    fill_in "Clarinspect", with: @inspection.clarinspect_id
    fill_in "Clarinspect inspection", with: @inspection.clarinspect_inspection
    fill_in "Hilti import", with: @inspection.hilti_import_id
    fill_in "Hilti project", with: @inspection.hilti_project_id
    fill_in "Penetration", with: @inspection.penetration
    fill_in "Project", with: @inspection.project_id
    fill_in "Reference", with: @inspection.reference
    click_on "Create Inspection"

    assert_text "Inspection was successfully created"
    click_on "Back"
  end

  test "should update Inspection" do
    visit inspection_url(@inspection)
    click_on "Edit this inspection", match: :first

    fill_in "Category", with: @inspection.category_id
    fill_in "Clarinspect", with: @inspection.clarinspect_id
    fill_in "Clarinspect inspection", with: @inspection.clarinspect_inspection
    fill_in "Hilti import", with: @inspection.hilti_import_id
    fill_in "Hilti project", with: @inspection.hilti_project_id
    fill_in "Penetration", with: @inspection.penetration
    fill_in "Project", with: @inspection.project_id
    fill_in "Reference", with: @inspection.reference
    click_on "Update Inspection"

    assert_text "Inspection was successfully updated"
    click_on "Back"
  end

  test "should destroy Inspection" do
    visit inspection_url(@inspection)
    click_on "Destroy this inspection", match: :first

    assert_text "Inspection was successfully destroyed"
  end
end
