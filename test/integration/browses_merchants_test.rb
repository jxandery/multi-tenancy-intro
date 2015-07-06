require_relative '../test_helper'

class BrowsesMerchantsTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_views_a_merchants_store_page
    merchant = Merchant.create(name: "CoolersRUs")
    visit merchant_path(merchant)
    assert_equal 200, page.status_code

    within('h1') do
      assert page.has_content?(merchant.name), "page should have an CoolersRUs"
    end
  end

  def test_it_views_a_specific_item
    merchant = Merchant.create(name: "CoolersRUs")
    item = Item.create(name: 'new item', description: "cool item", merchant_id: merchant.id)
    visit merchant_path(merchant)

    within('li') do
      assert page.has_content?(item.name)
      assert page.has_content?(item.description)
      refute page.has_content?(item.merchant_id)
    end

  end
end

