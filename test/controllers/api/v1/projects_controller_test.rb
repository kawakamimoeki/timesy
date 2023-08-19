require "test_helper"

class Api::V1::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get preview" do
    post api_v1_preview_project_url, params: { project: { codename: "test", title: "test", body: "Hello, world!" } }
    assert_response :success
  end

  test "should create project" do
    user = users(:current)
    access_token = AccessToken.create(user: user)
    post api_v1_create_project_url, params: { project: { codename: "test", title: "test", body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not create project" do
    post api_v1_create_project_url, params: { project: { codename: "test", title: "test", body: "Hello, world!" } }
    assert_response :unauthorized
  end

  test "should not create project with invalid access token" do
    user = users(:current)
    post api_v1_create_project_url, params: { project: { codename: "test", title: "test", body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end

  test "should update project" do
    user = users(:current)
    access_token = AccessToken.create(user: user)
    project = projects(:my_project)
    patch api_v1_update_project_url(project), params: { project: { id: project.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not update project" do
    user = users(:current)
    project = projects(:my_project)
    patch api_v1_update_project_url(project), params: { project: { id: project.id, body: "Hello, world!" } }
    assert_response :unauthorized
  end

  test "should not update project with invalid access token" do
    user = users(:current)
    project = projects(:my_project)
    patch api_v1_update_project_url(project), params: { project: { id: project.id, body: "Hello, world!" } },
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end

  test "should destroy project" do
    user = users(:current)
    access_token = AccessToken.create(user: user)
    project = projects(:my_project)
    delete api_v1_delete_project_url(project),
      headers: { "Authorization" => "Bearer #{access_token.token}" }
    assert_response :success
  end

  test "should not destroy project" do
    user = users(:current)
    project = projects(:my_project)
    delete api_v1_delete_project_url(project)
    assert_response :unauthorized
  end

  test "should not destroy project with invalid access token" do
    user = users(:current)
    project = projects(:my_project)
    delete api_v1_delete_project_url(project),
      headers: { "Authorization" => "Bearer #{user.id}" }
    assert_response :unauthorized
  end
end
