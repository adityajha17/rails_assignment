require "test_helper"

class ApplyStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get jid" do
    get apply_status_jid_url
    assert_response :success
  end

  test "should get uid" do
    get apply_status_uid_url
    assert_response :success
  end

  test "should get job_title" do
    get apply_status_job_title_url
    assert_response :success
  end

  test "should get u_name" do
    get apply_status_u_name_url
    assert_response :success
  end

  test "should get status:boolean" do
    get apply_status_status:boolean_url
    assert_response :success
  end
end
