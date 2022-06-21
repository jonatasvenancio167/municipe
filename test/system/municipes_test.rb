require "application_system_test_case"

class MunicipesTest < ApplicationSystemTestCase
  setup do
    @municipe = municipes(:one)
  end

  test "visiting the index" do
    visit municipes_url
    assert_selector "h1", text: "Municipes"
  end

  test "creating a Municipe" do
    visit municipes_url
    click_on "New Municipe"

    fill_in "Birth date", with: @municipe.birth_date
    fill_in "Cns", with: @municipe.cns
    fill_in "Cpf", with: @municipe.cpf
    fill_in "Email", with: @municipe.email
    fill_in "Full name", with: @municipe.full_name
    fill_in "Status", with: @municipe.status
    fill_in "Telephone", with: @municipe.telephone
    click_on "Create Municipe"

    assert_text "Municipe was successfully created"
    click_on "Back"
  end

  test "updating a Municipe" do
    visit municipes_url
    click_on "Edit", match: :first

    fill_in "Birth date", with: @municipe.birth_date
    fill_in "Cns", with: @municipe.cns
    fill_in "Cpf", with: @municipe.cpf
    fill_in "Email", with: @municipe.email
    fill_in "Full name", with: @municipe.full_name
    fill_in "Status", with: @municipe.status
    fill_in "Telephone", with: @municipe.telephone
    click_on "Update Municipe"

    assert_text "Municipe was successfully updated"
    click_on "Back"
  end

  test "destroying a Municipe" do
    visit municipes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Municipe was successfully destroyed"
  end
end
