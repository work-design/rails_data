require "application_system_test_case"

class DataRecordsTest < ApplicationSystemTestCase
  setup do
    @data_record = data_records(:one)
  end

  test "visiting the index" do
    visit data_records_url
    assert_selector "h1", text: "Data Records"
  end

  test "creating a Data record" do
    visit data_records_url
    click_on "New Data Record"

    click_on "Create Data record"

    assert_text "Data record was successfully created"
    click_on "Back"
  end

  test "updating a Data record" do
    visit data_records_url
    click_on "Edit", match: :first

    click_on "Update Data record"

    assert_text "Data record was successfully updated"
    click_on "Back"
  end

  test "destroying a Data record" do
    visit data_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Data record was successfully destroyed"
  end
end
