require "application_system_test_case"

class FilialsTest < ApplicationSystemTestCase
  setup do
    @filial = filials(:one)
  end

  test "visiting the index" do
    visit filials_url
    assert_selector "h1", text: "Filials"
  end

  test "creating a Filial" do
    visit filials_url
    click_on "New Filial"

    fill_in "Code", with: @filial.code
    fill_in "Name", with: @filial.name
    fill_in "Num", with: @filial.num
    click_on "Create Filial"

    assert_text "Filial was successfully created"
    click_on "Back"
  end

  test "updating a Filial" do
    visit filials_url
    click_on "Edit", match: :first

    fill_in "Code", with: @filial.code
    fill_in "Name", with: @filial.name
    fill_in "Num", with: @filial.num
    click_on "Update Filial"

    assert_text "Filial was successfully updated"
    click_on "Back"
  end

  test "destroying a Filial" do
    visit filials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filial was successfully destroyed"
  end
end
