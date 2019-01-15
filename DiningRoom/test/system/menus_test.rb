require "application_system_test_case"

class MenusTest < ApplicationSystemTestCase
  setup do
    @menu = menus(:one)
  end

  test "visiting the index" do
    visit menus_url
    assert_selector "h1", text: "Menus"
  end

  test "creating a Menu" do
    visit menus_url
    click_on "New Menu"

    fill_in "Dinner date", with: @menu.dinner_date
    fill_in "Dish one", with: @menu.dish_one
    fill_in "Dish three", with: @menu.dish_three
    fill_in "Dish two", with: @menu.dish_two
    fill_in "Soup", with: @menu.soup
    fill_in "Type", with: @menu.type
    click_on "Create Menu"

    assert_text "Menu was successfully created"
    click_on "Back"
  end

  test "updating a Menu" do
    visit menus_url
    click_on "Edit", match: :first

    fill_in "Dinner date", with: @menu.dinner_date
    fill_in "Dish one", with: @menu.dish_one
    fill_in "Dish three", with: @menu.dish_three
    fill_in "Dish two", with: @menu.dish_two
    fill_in "Soup", with: @menu.soup
    fill_in "Type", with: @menu.type
    click_on "Update Menu"

    assert_text "Menu was successfully updated"
    click_on "Back"
  end

  test "destroying a Menu" do
    visit menus_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Menu was successfully destroyed"
  end
end
