require_relative '../test_helper'

class BrowsesMerchantsTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_views_a_merchants_store_page
    merchant = Merchant.create(name: "CoolersRUs")
    visit "/merchants/#{merchant.id}"
    assert_equal 200, page.status_code

    within('h1') do
      assert page.has_content?('CoolersRUs'), "page should have an CoolersRUs"
    end
  end
end

