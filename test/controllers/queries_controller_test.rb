require 'test_helper'

class QueriesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should return query results" do 
    post :create, query: "SELECT * FROM AppData;"
    assert_response :success
  end

  test "returns 400 error with malicious input" do 
    post :create, query: "DELETE * FROM AppData;"
    assert_response :bad_request
  end

  test "returns 400 error regardless of string case" do 
    post :create, query: "delEte * FROM AppData;"
    assert_response :bad_request
  end

  test "returns error if not valid sql" do 
    post :create, query: "This will not work!"
    assert_response :bad_request
  end

end
