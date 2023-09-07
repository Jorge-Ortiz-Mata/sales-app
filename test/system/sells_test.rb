require "application_system_test_case"

class SellsTest < ApplicationSystemTestCase
  setup do
    @sell = sells(:one)
  end

  test "visiting the index" do
    visit sells_url
    assert_selector "h1", text: "Sells"
  end

  test "should create sell" do
    visit sells_url
    click_on "New sell"

    fill_in "Article", with: @sell.article_id
    fill_in "Comment", with: @sell.comment
    fill_in "Date of sell", with: @sell.date_of_sell
    fill_in "Day", with: @sell.day
    fill_in "Quantity", with: @sell.quantity
    click_on "Create Sell"

    assert_text "Sell was successfully created"
    click_on "Back"
  end

  test "should update Sell" do
    visit sell_url(@sell)
    click_on "Edit this sell", match: :first

    fill_in "Article", with: @sell.article_id
    fill_in "Comment", with: @sell.comment
    fill_in "Date of sell", with: @sell.date_of_sell
    fill_in "Day", with: @sell.day
    fill_in "Quantity", with: @sell.quantity
    click_on "Update Sell"

    assert_text "Sell was successfully updated"
    click_on "Back"
  end

  test "should destroy Sell" do
    visit sell_url(@sell)
    click_on "Destroy this sell", match: :first

    assert_text "Sell was successfully destroyed"
  end
end
