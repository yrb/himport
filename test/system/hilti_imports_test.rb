require "application_system_test_case"

class HiltiImportsTest < ApplicationSystemTestCase
  setup do
    @hilti_import = hilti_imports(:one)
  end

  test "visiting the index" do
    visit hilti_imports_url
    assert_selector "h1", text: "Hilti imports"
  end

  test "should create hilti import" do
    visit hilti_imports_url
    click_on "New hilti import"

    fill_in "Label", with: @hilti_import.label
    check "Processed" if @hilti_import.processed
    fill_in "Sent at", with: @hilti_import.sent_at
    click_on "Create Hilti import"

    assert_text "Hilti import was successfully created"
    click_on "Back"
  end

  test "should update Hilti import" do
    visit hilti_import_url(@hilti_import)
    click_on "Edit this hilti import", match: :first

    fill_in "Label", with: @hilti_import.label
    check "Processed" if @hilti_import.processed
    fill_in "Sent at", with: @hilti_import.sent_at.to_s
    click_on "Update Hilti import"

    assert_text "Hilti import was successfully updated"
    click_on "Back"
  end

  test "should destroy Hilti import" do
    visit hilti_import_url(@hilti_import)
    click_on "Destroy this hilti import", match: :first

    assert_text "Hilti import was successfully destroyed"
  end
end
