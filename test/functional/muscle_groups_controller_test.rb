require 'test_helper'

class MuscleGroupsControllerTest < ActionController::TestCase
  setup do
    @muscle_group = muscle_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:muscle_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create muscle_group" do
    assert_difference('MuscleGroup.count') do
      post :create, :muscle_group => @muscle_group.attributes
    end

    assert_redirected_to muscle_group_path(assigns(:muscle_group))
  end

  test "should show muscle_group" do
    get :show, :id => @muscle_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @muscle_group.to_param
    assert_response :success
  end

  test "should update muscle_group" do
    put :update, :id => @muscle_group.to_param, :muscle_group => @muscle_group.attributes
    assert_redirected_to muscle_group_path(assigns(:muscle_group))
  end

  test "should destroy muscle_group" do
    assert_difference('MuscleGroup.count', -1) do
      delete :destroy, :id => @muscle_group.to_param
    end

    assert_redirected_to muscle_groups_path
  end
end
