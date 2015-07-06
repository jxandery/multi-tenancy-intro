require_relative '../test_helper'

class BrowsesMerchantsTest < ActionDispatch::IntegrationTest

  def test_it_views_a_merchants_store_page
    merchant = Merchant.create(name: "CoolersRUs")
    visit "/merchants/#{merchant.id}"
    assert_equal 200, page.status_code

    within('h1')
    assert page.has_content?('CoolerRUs'), "page should have an CoolersRUs"
  end
end

