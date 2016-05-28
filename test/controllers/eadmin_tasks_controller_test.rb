require 'test_helper'

class EadminTasksControllerTest < ActionController::TestCase
  setup do
    @eadmin_task = eadmin_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eadmin_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eadmin_task" do
    assert_difference('EadminTask.count') do
      post :create, eadmin_task: { category: @eadmin_task.category, completed: @eadmin_task.completed, completed_at: @eadmin_task.completed_at, description: @eadmin_task.description, due_date: @eadmin_task.due_date, media: @eadmin_task.media, title: @eadmin_task.title, when_due: @eadmin_task.when_due }
    end

    assert_redirected_to eadmin_task_path(assigns(:eadmin_task))
  end

  test "should show eadmin_task" do
    get :show, id: @eadmin_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eadmin_task
    assert_response :success
  end

  test "should update eadmin_task" do
    patch :update, id: @eadmin_task, eadmin_task: { category: @eadmin_task.category, completed: @eadmin_task.completed, completed_at: @eadmin_task.completed_at, description: @eadmin_task.description, due_date: @eadmin_task.due_date, media: @eadmin_task.media, title: @eadmin_task.title, when_due: @eadmin_task.when_due }
    assert_redirected_to eadmin_task_path(assigns(:eadmin_task))
  end

  test "should destroy eadmin_task" do
    assert_difference('EadminTask.count', -1) do
      delete :destroy, id: @eadmin_task
    end

    assert_redirected_to eadmin_tasks_path
  end
end
