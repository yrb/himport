require "application_system_test_case"

class FloorPlansTest < ApplicationSystemTestCase
  setup do
    @floor_plan = floor_plans(:one)
  end

  test "visiting the index" do
    visit floor_plans_url
    assert_selector "h1", text: "Floor plans"
  end

  test "should create floor plan" do
    visit floor_plans_url
    click_on "New floor plan"

    fill_in "Clarinspect asset", with: @floor_plan.clarinspect_asset_id
    fill_in "Clarinspect drawing", with: @floor_plan.clarinspect_drawing_id
    fill_in "Metadata", with: @floor_plan.metadata
    click_on "Create Floor plan"

    assert_text "Floor plan was successfully created"
    click_on "Back"
  end

  test "should update Floor plan" do
    visit floor_plan_url(@floor_plan)
    click_on "Edit this floor plan", match: :first

    fill_in "Clarinspect asset", with: @floor_plan.clarinspect_asset_id
    fill_in "Clarinspect drawing", with: @floor_plan.clarinspect_drawing_id
    fill_in "Metadata", with: @floor_plan.metadata
    click_on "Update Floor plan"

    assert_text "Floor plan was successfully updated"
    click_on "Back"
  end

  test "should destroy Floor plan" do
    visit floor_plan_url(@floor_plan)
    click_on "Destroy this floor plan", match: :first

    assert_text "Floor plan was successfully destroyed"
  end
end
