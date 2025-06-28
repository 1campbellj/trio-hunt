require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @card = cards(:one)
  end

  test "visiting the index" do
    visit cards_url
    assert_selector "h1", text: "Cards"
  end

  test "should create card" do
    visit cards_url
    click_on "New card"

    fill_in "Color", with: @card.color
    fill_in "Number", with: @card.number
    fill_in "Shape", with: @card.shape
    fill_in "Texture", with: @card.texture
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "should update Card" do
    visit card_url(@card)
    click_on "Edit this card", match: :first

    fill_in "Color", with: @card.color
    fill_in "Number", with: @card.number
    fill_in "Shape", with: @card.shape
    fill_in "Texture", with: @card.texture
    click_on "Update Card"

    assert_text "Card was successfully updated"
    click_on "Back"
  end

  test "should destroy Card" do
    visit card_url(@card)
    accept_confirm { click_on "Destroy this card", match: :first }

    assert_text "Card was successfully destroyed"
  end
end
