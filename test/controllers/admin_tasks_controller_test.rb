require 'test_helper'

class AdminTasksControllerTest < ActionController::TestCase
  setup do
    @admin_task = admin_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_task" do
    assert_difference('AdminTask.count') do
      post :create, admin_task: { category: @admin_task.category, description: @admin_task.description, due_date: @admin_task.due_date, media: @admin_task.media, title: @admin_task.title, when: @admin_task.when }
    end

    assert_redirected_to admin_task_path(assigns(:admin_task))
  end

  test "should show admin_task" do
    get :show, id: @admin_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_task
    assert_response :success
  end

  test "should update admin_task" do
    patch :update, id: @admin_task, admin_task: { category: @admin_task.category, description: @admin_task.description, due_date: @admin_task.due_date, media: @admin_task.media, title: @admin_task.title, when: @admin_task.when }
    assert_redirected_to admin_task_path(assigns(:admin_task))
  end

  test "should destroy admin_task" do
    assert_difference('AdminTask.count', -1) do
      delete :destroy, id: @admin_task
    end

    assert_redirected_to admin_tasks_path
  end
end
