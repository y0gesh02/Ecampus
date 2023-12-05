require "application_system_test_case"

class CampusDrivesTest < ApplicationSystemTestCase
  setup do
    @campus_drife = campus_drives(:one)
  end

  test "visiting the index" do
    visit campus_drives_url
    assert_selector "h1", text: "Campus drives"
  end

  test "should create campus drive" do
    visit campus_drives_url
    click_on "New campus drive"

    fill_in "Description", with: @campus_drife.description
    fill_in "End date", with: @campus_drife.end_date
    fill_in "Location", with: @campus_drife.location
    fill_in "Name", with: @campus_drife.name
    fill_in "Start date", with: @campus_drife.start_date
    fill_in "User", with: @campus_drife.user_id
    click_on "Create Campus drive"

    assert_text "Campus drive was successfully created"
    click_on "Back"
  end

  test "should update Campus drive" do
    visit campus_drife_url(@campus_drife)
    click_on "Edit this campus drive", match: :first

    fill_in "Description", with: @campus_drife.description
    fill_in "End date", with: @campus_drife.end_date
    fill_in "Location", with: @campus_drife.location
    fill_in "Name", with: @campus_drife.name
    fill_in "Start date", with: @campus_drife.start_date
    fill_in "User", with: @campus_drife.user_id
    click_on "Update Campus drive"

    assert_text "Campus drive was successfully updated"
    click_on "Back"
  end

  test "should destroy Campus drive" do
    visit campus_drife_url(@campus_drife)
    click_on "Destroy this campus drive", match: :first

    assert_text "Campus drive was successfully destroyed"
  end
end
