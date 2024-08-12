require "test_helper"

class HiltiImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hilti_import = hilti_imports(:one)
  end

  test "should get index" do
    get hilti_imports_url
    assert_response :success
  end

  test "should get new" do
    get new_hilti_import_url
    assert_response :success
  end

  test "should create hilti_import" do
    assert_difference("HiltiImport.count") do
      post hilti_imports_url, params: { hilti_import: { label: @hilti_import.label, processed: @hilti_import.processed, sent_at: @hilti_import.sent_at } }
    end

    assert_redirected_to hilti_import_url(HiltiImport.last)
  end

  test "should show hilti_import" do
    get hilti_import_url(@hilti_import)
    assert_response :success
  end

  test "should get edit" do
    get edit_hilti_import_url(@hilti_import)
    assert_response :success
  end

  test "should update hilti_import" do
    patch hilti_import_url(@hilti_import), params: { hilti_import: { label: @hilti_import.label, processed: @hilti_import.processed, sent_at: @hilti_import.sent_at } }
    assert_redirected_to hilti_import_url(@hilti_import)
  end

  test "should destroy hilti_import" do
    assert_difference("HiltiImport.count", -1) do
      delete hilti_import_url(@hilti_import)
    end

    assert_redirected_to hilti_imports_url
  end
end
