require "application_system_test_case"

class DevicesTest < ApplicationSystemTestCase
  setup do
    @device = devices(:one)
  end

  test "visiting the index" do
    visit devices_url
    assert_selector "h1", text: "Devices"
  end

  test "creating a Device" do
    visit devices_url
    click_on "New Device"

    check "Cancellation" if @device.cancellation
    fill_in "Dateprod", with: @device.dateprod
    fill_in "Invnum", with: @device.invnum
    fill_in "Mark", with: @device.mark
    fill_in "Model", with: @device.model
    fill_in "Name", with: @device.name
    fill_in "Place", with: @device.place
    fill_in "Proc", with: @device.proc
    fill_in "Ram", with: @device.ram
    fill_in "Serial", with: @device.serial
    fill_in "Type", with: @device.type_id
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "updating a Device" do
    visit devices_url
    click_on "Edit", match: :first

    check "Cancellation" if @device.cancellation
    fill_in "Dateprod", with: @device.dateprod
    fill_in "Invnum", with: @device.invnum
    fill_in "Mark", with: @device.mark
    fill_in "Model", with: @device.model
    fill_in "Name", with: @device.name
    fill_in "Place", with: @device.place
    fill_in "Proc", with: @device.proc
    fill_in "Ram", with: @device.ram
    fill_in "Serial", with: @device.serial
    fill_in "Type", with: @device.type_id
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "destroying a Device" do
    visit devices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Device was successfully destroyed"
  end
end
