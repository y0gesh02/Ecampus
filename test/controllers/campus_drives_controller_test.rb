require "test_helper"

class CampusDrivesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campus_drife = campus_drives(:one)
  end

  test "should get index" do
    get campus_drives_url
    assert_response :success
  end

  test "should get new" do
    get new_campus_drife_url
    assert_response :success
  end

  test "should create campus_drife" do
    assert_difference("CampusDrive.count") do
      post campus_drives_url, params: { campus_drife: { description: @campus_drife.description, end_date: @campus_drife.end_date, location: @campus_drife.location, name: @campus_drife.name, start_date: @campus_drife.start_date, user_id: @campus_drife.user_id } }
    end

    assert_redirected_to campus_drife_url(CampusDrive.last)
  end

  test "should show campus_drife" do
    get campus_drife_url(@campus_drife)
    assert_response :success
  end

  test "should get edit" do
    get edit_campus_drife_url(@campus_drife)
    assert_response :success
  end

  test "should update campus_drife" do
    patch campus_drife_url(@campus_drife), params: { campus_drife: { description: @campus_drife.description, end_date: @campus_drife.end_date, location: @campus_drife.location, name: @campus_drife.name, start_date: @campus_drife.start_date, user_id: @campus_drife.user_id } }
    assert_redirected_to campus_drife_url(@campus_drife)
  end

  test "should destroy campus_drife" do
    assert_difference("CampusDrive.count", -1) do
      delete campus_drife_url(@campus_drife)
    end

    assert_redirected_to campus_drives_url
  end
end
