require "application_system_test_case"

class RequirementsTest < ApplicationSystemTestCase
  setup do
    @requirement = requirements(:one)
  end

  test "visiting the index" do
    visit requirements_url
    assert_selector "h1", text: "Requirements"
  end

  test "creating a Requirement" do
    visit requirements_url
    click_on "New Requirement"

    fill_in "Amount", with: @requirement.amount
    check "Done" if @requirement.done
    fill_in "Filial", with: @requirement.filial_id
    fill_in "For what", with: @requirement.for_what
    check "Got" if @requirement.got
    fill_in "Level", with: @requirement.level
    fill_in "Link", with: @requirement.link
    fill_in "Price", with: @requirement.price
    fill_in "Wishes", with: @requirement.wishes
    click_on "Create Requirement"

    assert_text "Requirement was successfully created"
    click_on "Back"
  end

  test "updating a Requirement" do
    visit requirements_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @requirement.amount
    check "Done" if @requirement.done
    fill_in "Filial", with: @requirement.filial_id
    fill_in "For what", with: @requirement.for_what
    check "Got" if @requirement.got
    fill_in "Level", with: @requirement.level
    fill_in "Link", with: @requirement.link
    fill_in "Price", with: @requirement.price
    fill_in "Wishes", with: @requirement.wishes
    click_on "Update Requirement"

    assert_text "Requirement was successfully updated"
    click_on "Back"
  end

  test "destroying a Requirement" do
    visit requirements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Requirement was successfully destroyed"
  end
end
