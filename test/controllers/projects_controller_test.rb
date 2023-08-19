require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    user = users(:current)
    get projects_url(user.username)
    assert_response :success
  end

  test "should get show" do
    project = projects(:my_project)
    get project_url(project.user.username, project.codename)
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should get edit" do
    project = projects(:my_project)
    ApplicationController.stub_any_instance :current_user, project.user do
      get edit_project_url(project.user.username, project.codename)
      assert_response :success
    end
  end

  test "should not get edit if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "test@example.com", username: "test", name: "Test") do
      project = projects(:my_project)
      get edit_project_url(project.user.username, project.codename)
      assert_response :redirect
    end
  end
  
  test "should post create" do
    user = users(:current)
    ApplicationController.stub_any_instance :current_user, user do
      post create_project_url, params: { project: { title: 'title', codename: 'codename', link: 'https://example.com' } }
      assert_response :redirect
    end
  end

  test "should patch update" do
    project = projects(:my_project)
    ApplicationController.stub_any_instance :current_user, project.user do
      patch update_project_url(project.user.username, project.id), params: { project: { title: 'title', codename: 'codename', link: 'https://example.com' } }
      assert_response :redirect
    end
  end

  test "should not update project if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "test@example.com", username: "test", name: "Test") do
      project = projects(:my_project)
      patch update_project_url(project.user.username, project.id), params: { project: { title: 'title', codename: 'codename', link: 'https://example.com' } }
      assert_response :redirect
    end
  end

  test "should delete destroy" do
    project = projects(:my_project)
    ApplicationController.stub_any_instance :current_user, project.user do
      delete delete_project_url(project.user.username, project.codename)
      assert_response :redirect
    end
  end

  test "should not destroy project if not authorized" do
    ApplicationController.stub_any_instance :current_user, User.create(email: "current@example.com", username: "current", name: "Current") do
      project = projects(:my_project)
      assert_difference('Project.count', 0) do
        delete delete_project_url(project.user.username, project.codename)
      end
      assert_response :redirect
    end
  end
end
