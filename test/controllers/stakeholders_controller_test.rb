require 'test_helper'

class StakeholdersControllerTest < ActionController::TestCase
  setup do
    @stakeholder = stakeholders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stakeholders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stakeholder" do
    assert_difference('Stakeholder.count') do
      post :create, stakeholder: { account_id: @stakeholder.account_id, department: @stakeholder.department, email: @stakeholder.email, name: @stakeholder.name, template: @stakeholder.template }
    end

    assert_redirected_to stakeholder_path(assigns(:stakeholder))
  end

  test "should show stakeholder" do
    get :show, id: @stakeholder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stakeholder
    assert_response :success
  end

  test "should update stakeholder" do
    patch :update, id: @stakeholder, stakeholder: { account_id: @stakeholder.account_id, department: @stakeholder.department, email: @stakeholder.email, name: @stakeholder.name, template: @stakeholder.template }
    assert_redirected_to stakeholder_path(assigns(:stakeholder))
  end

  test "should destroy stakeholder" do
    assert_difference('Stakeholder.count', -1) do
      delete :destroy, id: @stakeholder
    end

    assert_redirected_to stakeholders_path
  end
end
