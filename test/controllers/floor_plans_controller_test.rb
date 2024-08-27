require "test_helper"

class FloorPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @floor_plan = floor_plans(:one)
  end

  test "should get index" do
    get floor_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_floor_plan_url
    assert_response :success
  end

  test "should create floor_plan" do
    assert_difference("FloorPlan.count") do
      post floor_plans_url, params: { floor_plan: { clarinspect_asset_id: @floor_plan.clarinspect_asset_id, clarinspect_drawing_id: @floor_plan.clarinspect_drawing_id, metadata: @floor_plan.metadata } }
    end

    assert_redirected_to floor_plan_url(FloorPlan.last)
  end

  test "should show floor_plan" do
    get floor_plan_url(@floor_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_floor_plan_url(@floor_plan)
    assert_response :success
  end

  test "should update floor_plan" do
    patch floor_plan_url(@floor_plan), params: { floor_plan: { clarinspect_asset_id: @floor_plan.clarinspect_asset_id, clarinspect_drawing_id: @floor_plan.clarinspect_drawing_id, metadata: @floor_plan.metadata } }
    assert_redirected_to floor_plan_url(@floor_plan)
  end

  test "should destroy floor_plan" do
    assert_difference("FloorPlan.count", -1) do
      delete floor_plan_url(@floor_plan)
    end

    assert_redirected_to floor_plans_url
  end
end
